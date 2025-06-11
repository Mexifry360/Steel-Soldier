import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIWorkoutService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> generateWorkoutPlan() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    final userDoc = await _db.collection('users').doc(uid).get();
    final onboarding = userDoc.data()?['onboarding'];

    if (onboarding == null) throw Exception("Onboarding data missing");

    final prompt = _buildPrompt(onboarding);

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer YOUR_OPENAI_API_KEY",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4",
        "messages": [
          {"role": "system", "content": "You are a tactical fitness coach helping soldiers train for the Army Combat Fitness Test (ACFT)."},
          {"role": "user", "content": prompt},
        ],
        "temperature": 0.8,
      }),
    );

    final decoded = jsonDecode(response.body);
    final aiPlan = decoded['choices']?[0]?['message']?['content'];

    if (aiPlan != null) {
      await _db.collection('users').doc(uid).collection('plans').add({
        'created_at': DateTime.now(),
        'plan': aiPlan,
      });
    }
  }

  String _buildPrompt(Map<String, dynamic> onboarding) {
    return '''
Generate a 7-day tactical fitness plan for a soldier with the following profile:
- Rank: ${onboarding['rank']}
- Unit/Platoon: ${onboarding['platoon']}
- Injuries: ${onboarding['injuries']}
- ACFT Scores: ${onboarding['acft_scores']}
- Fitness Goal: ${onboarding['goal']}
- Weekly Training Frequency: ${onboarding['frequency']}
- Equipment Access: ${onboarding['equipment']}
- Training Time Preference: ${onboarding['time']}
- Fitness Level: ${onboarding['fitness_level']}
- Let AI Adjust: ${onboarding['ai_adjust']}

The plan should support ACFT goals, use proper tactical conditioning, and respect injury limitations and training time. Format it clearly by day.
''';
  }
}
