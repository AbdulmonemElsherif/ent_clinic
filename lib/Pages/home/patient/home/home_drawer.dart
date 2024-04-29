import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/appointment/create_appointment_page.dart';
import 'package:ent_clinic/Pages/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import '../../../auth/signin.dart';
import '../../about_us/about_us.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  Future<DocumentSnapshot> getUserData() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.collection('users').doc(firebaseUser!.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder(
            future: getUserData(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.account_circle, size: 48, color: Colors.white),
                        const SizedBox(width: 16),
                        Text(
                          snapshot.data!['name'], // Replace with actual user name
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Text("No data");
              }
              return const CircularProgressIndicator();
            },
          ),
          ListTile(
            title: const Text('Book Appointment'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAppointmentPage()),
              );

            },
          ),
          ListTile(
            title: const Text('Services'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement services page
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
              // TODO: Implement contact us page
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: AdaptiveTheme.of(context).mode.isDark,
            onChanged: (bool value) {
              AdaptiveTheme.of(context).toggleThemeMode();
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