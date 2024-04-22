import 'package:ent_clinic/Pages/profile/profile.dart';
import 'package:flutter/material.dart';


import '../../../auth/signin.dart';
import '../../about_us/about_us.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: GestureDetector(
              onTap: () {
                // Navigate to profile page
                Navigator.pop(context); // Close the drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Row(
                children: [
                  // Add user icon here
                  Icon(Icons.account_circle, size: 48, color: Colors.white),
                  SizedBox(width: 16), // Add spacing between icon and name
                  Text(
                    'User Name', // Replace with actual user name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Book Appointment'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to appointment booking screen
            },
          ),
          ListTile(
            title: const Text('Services'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to services screen
            },
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutUsPage()),
            );
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to contact screen
            },
          ),
          const Divider(), // Add a divider for visual separation
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
