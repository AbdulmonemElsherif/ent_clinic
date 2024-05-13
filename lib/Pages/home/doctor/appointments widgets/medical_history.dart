import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewMedicalInfoPage extends StatefulWidget {
  final String documentId;

  ViewMedicalInfoPage({required this.documentId});

  @override
  _ViewMedicalInfoPageState createState() => _ViewMedicalInfoPageState();
}

class _ViewMedicalInfoPageState extends State<ViewMedicalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Medical Information'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(widget.documentId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Are you a smoker'),
                  subtitle: Text(data['smoker']),
                ),
                ListTile(
                  title: Text('Special Medical Habit'),
                  subtitle: Text(data['specialMedicalHabits']),
                ),
                ListTile(
                  title: Text('Chronic Diseases'),
                  subtitle: Text(data['chronicDiseases'].join(', ')),
                ),
                ListTile(
                  title: Text('Drugs'),
                  subtitle: Text(data['drugs'].join(', ')),
                ),
                ListTile(
                  title: Text('Blood Type'),
                  subtitle: Text(data['bloodType']),
                ),
                ListTile(
                  title: Text('Allergies'),
                  subtitle: Text(data['allergies'].join(', ')),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}