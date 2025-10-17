import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Blocked Words'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to blocked words screen
            },
          ),
        ],
      ),
    );
  }
}
