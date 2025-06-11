import 'package:flutter/material.dart';

class GraphsScreen extends StatelessWidget {
  const GraphsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GraphsScreen'),
        backgroundColor: Colors.green.shade900,
      ),
      backgroundColor: const Color(0xFF121212),
      body: const Center(
        child: Text(
          'GraphsScreen Content Here',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ),
    );
  }
}
