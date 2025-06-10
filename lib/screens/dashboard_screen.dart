import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEEE, MMM d').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Mission Dashboard'),
        backgroundColor: Colors.green.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Welcome, Warrior', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text('Today is $today', style: TextStyle(color: Colors.grey.shade400)),
            const SizedBox(height: 20),
            _buildCard('🎯 Goals', 'Track and adjust your objectives'),
            _buildCard('📈 Progress Graphs', 'ACFT, Volume & Pain Trends'),
            _buildCard('📅 Smart Calendar', 'View planned & makeup workouts'),
            _buildCard('💀 Combat Conditioning', 'Ruck, Sprints, Mobility'),
            _buildCard('🧠 AI Coach', 'Analyzing readiness and adaptation...'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle) {
    return Card(
      color: const Color(0xFF2A2A2A),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
        onTap: () {}, // ⬅️ We'll wire up navigation later
      ),
    );
  }
}
