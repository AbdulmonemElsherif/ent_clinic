import 'package:flutter/material.dart';

import '../auth/signin.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
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
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
