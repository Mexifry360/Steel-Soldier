import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'home_screen.dart';

class BiometricLoginScreen extends StatefulWidget {
  const BiometricLoginScreen({super.key});

  @override
  State<BiometricLoginScreen> createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthenticating = false;
  String _authStatus = 'Not Authenticated';

  Future<void> _authenticate() async {
    try {
      setState(() {
        _isAuthenticating = true;
        _authStatus = 'Authenticating...';
      });

      bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to access Steel Soldier',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      setState(() {
        _authStatus = authenticated ? 'Authenticated!' : 'Failed to authenticate';
        _isAuthenticating = false;
      });

      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _authStatus = 'Error: $e';
        _isAuthenticating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_authStatus),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isAuthenticating ? null : _authenticate,
              child: const Text('Login with Biometrics'),
            ),
          ],
        ),
      ),
    );
  }
}
