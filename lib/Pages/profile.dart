import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example patient data (replace with actual patient data)
    String patientName = 'John Doe';
    String patientID = '123456789';
    String patientDOB = 'January 1, 1980';
    String patientGender = 'Male';
    String patientEmail = 'johndoe@example.com';
    String patientPhone = '+1 (555) 123-4567';

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
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
                  subtitle: Text(patientName),
                ),
                ListTile(
                  title: Text('Patient ID'),
                  subtitle: Text(patientID),
                ),
                ListTile(
                  title: Text('Date of Birth'),
                  subtitle: Text(patientDOB),
                ),
                ListTile(
                  title: Text('Gender'),
                  subtitle: Text(patientGender),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(patientEmail),
                ),
                ListTile(
                  title: Text('Phone'),
                  subtitle: Text(patientPhone),
                ),
                // Add more patient data as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
