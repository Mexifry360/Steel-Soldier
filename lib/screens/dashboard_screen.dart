import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Import destination screens
import 'goals_screen.dart';
import 'graphs_screen.dart';
import 'calendar_screen.dart';
import 'conditioning_screen.dart';
import 'ai_coach_screen.dart';

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
            _buildCard(context, '🎯 Goals', 'Track and adjust your objectives', const GoalsScreen()),
            _buildCard(context, '📈 Progress Graphs', 'ACFT, Volume & Pain Trends', const GraphsScreen()),
            _buildCard(context, '📅 Smart Calendar', 'View planned & makeup workouts', const CalendarScreen()),
            _buildCard(context, '💀 Combat Conditioning', 'Ruck, Sprints, Mobility', const ConditioningScreen()),
            _buildCard(context, '🧠 AI Coach', 'Analyzing readiness and adaptation...', const AiCoachScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String subtitle, Widget destination) {
    return Card(
      color: const Color(0xFF2A2A2A),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
        },
      ),
    );
  }
}
