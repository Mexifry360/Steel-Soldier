
import 'package:flutter/material.dart';

class BiometricLoginScreen extends StatelessWidget {
  const BiometricLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biometric Login")),
      body: const Center(child: Text("Biometric login setup here.")),
    );
  }
}
