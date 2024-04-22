import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<DocumentSnapshot> getUserProfile() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance.collection('users').doc(firebaseUser!.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getUserProfile(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Patient Information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      ListTile(
                        title: Text('Name'),
                        subtitle: Text(snapshot.data!['name']),
                      ),
                      ListTile(
                        title: Text('Patient ID'),
                        subtitle: Text(snapshot.data!['patientID']),
                      ),
                      ListTile(
                        title: Text('Date of Birth'),
                        subtitle: Text(snapshot.data!['dob']), // Use 'dob' key
                      ),
                      ListTile(
                        title: Text('Gender'),
                        subtitle: Text(snapshot.data!['gender']), // Use 'gender' key
                      ),
                      ListTile(
                        title: Text('Email'),
                        subtitle: Text(snapshot.data!['email']), // Use 'email' key
                      ),
                      ListTile(
                        title: Text('Phone'),
                        subtitle: Text(snapshot.data!['phone']), // Use 'phone' key
                      ),
                      // Add more patient data as needed
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}