

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  SettingsScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: toggleTheme,
          child: Text('Toggle Theme'),
        ),
      ),
    );
  }
}
