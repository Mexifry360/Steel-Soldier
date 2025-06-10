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
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Today's Workout"),
        backgroundColor: Colors.green.shade900,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final item = workouts[index];
          return Card(
            color: const Color(0xFF2A2A2A),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Image.asset(item['icon']!, width: 50, height: 50),
              title: Text(item['name']!, style: const TextStyle(color: Colors.white)),
              subtitle: Row(
                children: [
                  const Text('Pain:', style: TextStyle(color: Colors.white70)),
                  const SizedBox(width: 5),
                  _ratingDropdown(),
                  const SizedBox(width: 20),
                  const Text('Effort:', style: TextStyle(color: Colors.white70)),
                  const SizedBox(width: 5),
                  _ratingDropdown(),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
                child: const Text('Done'),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _ratingDropdown() {
    return DropdownButton<String>(
      items: ['1','2','3','4','5','6','7','8','9','10']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) {},
      hint: const Text('1-10', style: TextStyle(color: Colors.white)),
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      underline: const SizedBox(),
    );
  }
}
