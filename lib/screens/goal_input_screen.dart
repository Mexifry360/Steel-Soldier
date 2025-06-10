import 'package:flutter/material.dart';
import 'home_screen.dart';

class GoalInputScreen extends StatefulWidget {
  const GoalInputScreen({super.key});

  @override
  State<GoalInputScreen> createState() => _GoalInputScreenState();
}

class _GoalInputScreenState extends State<GoalInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _injuryController = TextEditingController();

  void _continue() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        title: const Text('Your Goals'),
        backgroundColor: Colors.green.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fitness Goal & Injury Profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _goalController,
                decoration: const InputDecoration(
                  labelText: 'Fitness Goals',
                ),
                validator: (value) => value!.isEmpty ? 'Enter your goals' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _injuryController,
                decoration: const InputDecoration(
                  labelText: 'Injury Profile (if any)',
                ),
                validator: (value) => null, // Optional
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
                  child: const Text('Continue to Dashboard'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
