import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: const [
          Card(child: Center(child: Text('ACFT Progress'))),
          Card(child: Center(child: Text('Workout Calendar'))),
          Card(child: Center(child: Text('Pain & Effort Logs'))),
          Card(child: Center(child: Text('Supervisor Access'))),
        ],
      ),
    );
  }
}
