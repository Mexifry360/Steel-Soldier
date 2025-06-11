import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/ai_workout_service.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class AIWorkoutPlanScreen extends StatefulWidget {
  const AIWorkoutPlanScreen({super.key});

  @override
  State<AIWorkoutPlanScreen> createState() => _AIWorkoutPlanScreenState();
}

class _AIWorkoutPlanScreenState extends State<AIWorkoutPlanScreen> {
  String? _error;
  bool _loading = false;

  Future<void> _getPlan() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await AIWorkoutService().generateWorkoutPlan();
    } catch (e) {
      setState(() => _error = 'Failed to generate plan: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _exportPDF(List<Map<String, dynamic>> plans) async {
    final pdf = pw.Document();

    for (var plan in plans) {
      final date = DateFormat.yMMMd().format(plan['created_at'].toDate());
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Workout Plan - $date", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(plan['plan']),
              ],
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Not logged in',
            style: TextStyle(fontSize: 24, color: Colors.red),
          ),
        ),
      );
    }

    final uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Workout Plan'),
        backgroundColor: Colors.green.shade900,
      ),
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.bolt),
                  label: const Text('Generate Plan'),
                  onPressed: _loading ? null : _getPlan,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text("Export"),
                  onPressed: () async {
                    final snapshot = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('plans')
                        .orderBy('created_at', descending: true)
                        .get();
                    final plans = snapshot.docs.map((doc) => doc.data()).toList();
                    await _exportPDF(plans);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_loading) const CircularProgressIndicator(),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.redAccent)),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('plans')
                    .orderBy('created_at', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Text("No plans yet", style: TextStyle(color: Colors.white70));
                  }

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final plan = docs[index]['plan'];
                      final date = docs[index]['created_at'].toDate();
                      return Card(
                        color: const Color(0xFF2A2A2A),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ExpansionTile(
                          iconColor: Colors.white54,
                          collapsedIconColor: Colors.white54,
                          title: Text("Plan from ${DateFormat.yMMMd().format(date)}",
                              style: const TextStyle(color: Colors.white)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(plan, style: const TextStyle(color: Colors.white70)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () => docs[index].reference.delete(),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
