import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final List<Map<String, String>> workouts = [
    {'name': 'Deadlift (3RM)', 'icon': 'assets/images/deadlift.png'},
    {'name': 'Standing Power Throw', 'icon': 'assets/images/power_throw.png'},
    {'name': 'Push-Ups', 'icon': 'assets/images/pushup.png'},
    {'name': 'Sprint-Drag-Carry', 'icon': 'assets/images/sprint_drag.png'},
    {'name': 'Plank Hold', 'icon': 'assets/images/plank.png'},
    {'name': '2-Mile Run', 'icon': 'assets/images/run.png'},
  ];

  final Map<int, String> _painRatings = {};
  final Map<int, String> _effortRatings = {};

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _saveAllWorkouts() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User not logged in")));
      return;
    }

    final now = DateTime.now();
    final docId = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final List<Map<String, dynamic>> workoutEntries = [];

    for (int i = 0; i < workouts.length; i++) {
      final workout = workouts[i];
      final pain = _painRatings[i];
      final effort = _effortRatings[i];

      if (pain == null || effort == null) continue;

      workoutEntries.add({
        'name': workout['name'],
        'pain': int.parse(pain),
        'effort': int.parse(effort),
      });
    }

    if (workoutEntries.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please complete at least one workout")));
      return;
    }

    await _db
        .collection('users')
        .doc(uid)
        .collection('workout_logs')
        .doc(docId)
        .set({
          'date': now,
          'entries': workoutEntries,
          'timestamp': FieldValue.serverTimestamp(),
        });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Workout log saved successfully!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Today's Workout"),
        backgroundColor: Colors.green.shade900,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final item = workouts[index];
          return Card(
            color: const Color(0xFF2A2A2A),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Image.asset(item['icon']!, width: 50, height: 50),
              title: Text(item['name']!, style: const TextStyle(color: Colors.white)),
              subtitle: Row(
                children: [
                  const Text('Pain:', style: TextStyle(color: Colors.white70)),
                  const SizedBox(width: 5),
                  _ratingDropdown(
                    value: _painRatings[index],
                    onChanged: (val) => setState(() => _painRatings[index] = val!),
                  ),
                  const SizedBox(width: 20),
                  const Text('Effort:', style: TextStyle(color: Colors.white70)),
                  const SizedBox(width: 5),
                  _ratingDropdown(
                    value: _effortRatings[index],
                    onChanged: (val) => setState(() => _effortRatings[index] = val!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green.shade700,
        onPressed: _saveAllWorkouts,
        label: const Text('Save All Workouts'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  Widget _ratingDropdown({String? value, required ValueChanged<String?> onChanged}) {
    return DropdownButton<String>(
      value: value,
      items: List.generate(10, (i) => '${i + 1}')
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      hint: const Text('1-10', style: TextStyle(color: Colors.white)),
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      underline: const SizedBox(),
    );
  }
}
