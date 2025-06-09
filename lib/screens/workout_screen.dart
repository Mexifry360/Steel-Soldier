
import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  final List<Map<String, String>> workouts = [
    {'name': 'Deadlift (3RM)', 'icon': 'assets/images/deadlift.png'},
    {'name': 'Standing Power Throw', 'icon': 'assets/images/power_throw.png'},
    {'name': 'Push-Ups', 'icon': 'assets/images/pushup.png'},
    {'name': 'Sprint-Drag-Carry', 'icon': 'assets/images/sprint_drag.png'},
    {'name': 'Plank Hold', 'icon': 'assets/images/plank.png'},
    {'name': '2-Mile Run', 'icon': 'assets/images/run.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today's Workout'),
        backgroundColor: Colors.green[900],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final item = workouts[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(
                item['icon']!,
                width: 50,
                height: 50,
              ),
              title: Text(
                item['name']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                child: Text('Done'),
              ),
            ),
          );
        },
      ),
    );
  }
}
