import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Steel Soldier Onboarding')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to next screen
          },
          child: const Text('Begin Setup'),
        ),
      ),
    );
  }
}
