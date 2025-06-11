import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIWorkoutService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<String> generateWorkoutPlan({bool forceRefresh = false}) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    final todayKey = DateTime.now().toIso8601String().substring(0, 10);
    final plansRef = _db.collection('users').doc(uid).collection('plans');

    if (!forceRefresh) {
      final existing = await plansRef
          .where('date_key', isEqualTo: todayKey)
          .limit(1)
          .get();
      if (existing.docs.isNotEmpty) {
        return existing.docs.first['plan'];
      }
    }

    final userDoc = await _db.collection('users').doc(uid).get();
    final onboarding = userDoc.data()?['onboarding'];
    if (onboarding == null) throw Exception("Onboarding data missing");

    final prompt = _buildPrompt(onboarding);
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a tactical fitness coach helping soldiers prepare for the Army Combat Fitness Test (ACFT)."
          },
          {"role": "user", "content": prompt},
        ],
        "temperature": 0.7,
        "max_tokens": 1000,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch AI plan: ${response.body}');
    }

    final decoded = jsonDecode(response.body);
    final aiPlan = decoded['choices'][0]['message']['content'];

    await plansRef.add({
      'created_at': Timestamp.now(),
      'date_key': todayKey,
      'plan': aiPlan,
    });

    return aiPlan;
  }

  String _buildPrompt(Map<String, dynamic> onboarding) {
    return '''
Design a 7-day personalized fitness program for a soldier preparing for the Army Combat Fitness Test (ACFT).

User profile:
- Rank: ${onboarding['rank']}
- Unit: ${onboarding['platoon']}
- Injuries: ${onboarding['injuries']}
- Current ACFT scores: ${onboarding['acft_scores']}
- Main goal: ${onboarding['goal']}
- Training days/week: ${onboarding['frequency']}
- Equipment access: ${onboarding['equipment']}
- Preferred training time: ${onboarding['time']}
- Fitness level: ${onboarding['fitness_level']}
- AI Adjustment: ${onboarding['ai_adjust']}

Include event-specific work (deadlifts, push-ups, sprint-drag-carry, plank, power throw, 2-mile run), tactical conditioning (rucking, mobility), and injury-safe progression if needed. Format by day.
''';
  }
}
