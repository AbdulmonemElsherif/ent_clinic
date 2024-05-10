import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/appointment/create_appointment_page.dart';
import 'package:ent_clinic/Pages/auth/signin.dart';
import 'package:ent_clinic/Pages/home/about_us/about_us.dart';
import 'package:ent_clinic/Pages/home/doctor/Screens/doctor_profile_screen.dart';
import 'package:ent_clinic/Pages/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class DoctorDrawer extends StatefulWidget {
  const DoctorDrawer({super.key});

  @override
  _DoctorDrawerState createState() => _DoctorDrawerState();
}

class _DoctorDrawerState extends State<DoctorDrawer> {
  Future<DocumentSnapshot> getUserData() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .get();
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
                        MaterialPageRoute(
                            builder: (context) => const DoctorProfile()),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.account_circle,
                            size: 48, color: Colors.white),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            snapshot.data!['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Text("No data");
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          ListTile(
            title: const Text('My Patients'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement navigation to My Patients page
            },
          ),
          ListTile(
            title: const Text('My Appointments'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement navigation to My Appointments page
            },
          ),
          ListTile(
            title: const Text('My Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DoctorProfile()),
              );
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
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
