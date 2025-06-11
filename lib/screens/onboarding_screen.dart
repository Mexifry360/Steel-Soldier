
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> responses = {};

  final List<Map<String, String>> questions = [
    {'key': 'rank', 'label': 'What is your current Army rank?'},
    {'key': 'platoon', 'label': 'Which unit or platoon are you assigned to?'},
    {'key': 'injuries', 'label': 'Do you have any existing injuries or physical limitations?'},
    {'key': 'acft_scores', 'label': 'What are your current ACFT event scores? (optional)'},
    {'key': 'goal', 'label': 'What is your top fitness goal?'},
    {'key': 'frequency', 'label': 'How many days per week can you train?'},
    {'key': 'equipment', 'label': 'Do you have access to gym equipment?'},
    {'key': 'time', 'label': 'What time of day do you prefer to train?'},
    {'key': 'fitness_level', 'label': 'Rate your fitness level (Beginner, Intermediate, Advanced)'},
    {'key': 'ai_adjust', 'label': 'Let AI adjust workouts based on your feedback? (Yes/No)'},
  ];

  Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;
  _formKey.currentState!.save();

  final uid = _auth.currentUser?.uid;
  if (uid == null) return;

  await _db.collection('users').doc(uid).set({
    'onboarding': responses,
    'onboardingComplete': true,
  }, SetOptions(merge: true)); // 🔁 Merge to avoid overwriting existing data

  if (!mounted) return;
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: questions.length + 1,
          itemBuilder: (context, index) {
            if (index == questions.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Finish Setup'),
                ),
              );
            }
            final question = questions[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(labelText: question['label']),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => responses[question['key']!] = val ?? '',
              ),
            );
          },
        ),
      ),
    );
  }
}
