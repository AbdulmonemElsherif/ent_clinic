import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: true, // This would ideally be linked to a state management solution.
            onChanged: (bool value) {
              // Handle change in value
            },
          ),
          ListTile(
            title: const Text('Account Settings'),
            onTap: () {
              // Navigate to account settings page or dialog
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              // Open privacy policy
            },
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              // Display about us information
            },
          ),
        ],
      ),
    );
  }
}
