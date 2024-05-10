import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  Future<DocumentSnapshot?> getDoctorProfile(BuildContext context) async {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userProfile = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser!.uid)
          .get();
    
      if (userProfile.exists && userProfile.get('role') == 'doctor') {
        return userProfile;
      } else {
        // Return null if the user is not a doctor
        return null;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DocumentSnapshot?>(
          future: getDoctorProfile(context),
          builder: (context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                Map<String, dynamic>? data =
                    snapshot.data!.data() as Map<String, dynamic>?;
                if (data != null) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // Doctor Information Card
                        _buildCard(
                          title: 'Doctor Information',
                          data: data,
                          fields: [
                            'Name',
                            'Speciality',
                            'Years of Experience',
                            'DOB',
                            'Gender',
                            'Email',
                            'Phone'
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text("No data");
                }
              } else {
                return const Text("No data");
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text("No data");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required Map<String, dynamic> data,
    required List<String> fields,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Speciality'),
              subtitle: Text(data['Speciality'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('DOB'),
              subtitle: Text(data['dob'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(data['email'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Gender'),
              subtitle: Text(data['gender'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Name'),
              subtitle: Text(data['name'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Phone'),
              subtitle: Text(data['phone'] ?? 'N/A'),
            ),
            ListTile(
              title: const Text('Role'),
              subtitle: Text(data['role'] ?? 'N/A'),
            ),
          ],
        ),
      ),
    );
  }
}