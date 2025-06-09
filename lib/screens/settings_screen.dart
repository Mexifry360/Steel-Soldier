import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Switch Theme'),
            trailing: const Icon(Icons.brightness_6),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Export Data'),
            trailing: const Icon(Icons.file_download),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting... (mock)')),
              );
            },
          ),
          ListTile(
            title: const Text('Request Data Deletion'),
            trailing: const Icon(Icons.delete),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
