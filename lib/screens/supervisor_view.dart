
import 'package:flutter/material.dart';

class SupervisorView extends StatelessWidget {
  const SupervisorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supervisor Dashboard")),
      body: const Center(child: Text("Supervisor features and reports go here.")),
    );
  }
}
