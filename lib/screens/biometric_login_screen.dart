import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricLoginScreen extends StatefulWidget {
  const BiometricLoginScreen({super.key});

  @override
  State<BiometricLoginScreen> createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<void> _authenticate() async {
    try {
      bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to access Steel Soldier',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (authenticated) {
        // Proceed to dashboard or next screen
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Auth failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: _authenticate,
          child: const Text('Login with Biometrics'),
        ),
      ),
    );
  }
}
