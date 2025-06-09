import 'package:flutter/material.dart';

class SupervisorView extends StatelessWidget {
  const SupervisorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supervisor Access')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Text('Unit Code: XYZ-123', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Read-only view of unit member fitness data.', style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            Expanded(
              child: Center(child: Text('Data Table Coming Soon')),
            ),
          ],
        ),
      ),
    );
  }
}
