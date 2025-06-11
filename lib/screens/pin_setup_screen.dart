import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home_screen.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final TextEditingController _pinController = TextEditingController();
  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set PIN')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _pinController, decoration: const InputDecoration(labelText: 'Enter a 4-digit PIN'), keyboardType: TextInputType.number, obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _savePin, child: const Text('Save PIN')),
          ],
        ),
      ),
    );
  }

  Future<void> _savePin() async {
    await _storage.write(key: 'user_pin', value: _pinController.text.trim());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }
}
