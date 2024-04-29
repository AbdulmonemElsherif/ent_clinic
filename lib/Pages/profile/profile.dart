import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/profile/edit_medical_info.dart';
import 'package:ent_clinic/Pages/profile/edit_patient_info.dart';


class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});


  Future<DocumentSnapshot> getUserProfile() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .get();

  }
  List<String> diseases = ['Diabetes', 'Hypertension', 'Asthma', 'Arthritis', 'Heart Disease'];
  List<String> drugs = ['Med1', 'Med2', 'Med3', 'Med4', 'Med5'];



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getUserProfile(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(  child:Column(
                children:[Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Patient Information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: const Text('Name'),
                        subtitle: Text(snapshot.data!['name']),
                      ),
                      ListTile(
                        title: const Text('Patient ID'),
                        subtitle: Text(snapshot.data!['patientID']),
                      ),
                      ListTile(
                        title: const Text('Date of Birth'),
                        subtitle: Text(snapshot.data!['dob']), // Use 'dob' key
                      ),
                      ListTile(
                        title: const Text('Gender'),
                        subtitle:
                            Text(snapshot.data!['gender']), // Use 'gender' key
                      ),
                      ListTile(
                        title: const Text('Email'),
                        subtitle:
                            Text(snapshot.data!['email']), // Use 'email' key
                      ),
                      ListTile(
                        title: const Text('Phone'),
                        subtitle:
                            Text(snapshot.data!['phone']), // Use 'phone' key
                      ),
                      // Add more patient data as needed
                    ],
                  ),
                ),
              ),Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Medical Information',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                         ListTile(
                          title: Text('Smoker'),
                          subtitle: Text("Yes"),
                        ),
                        ListTile(
                          title: Text('Special Medical Hospital'),
                          subtitle: Text("...."),
                        ),
                        ListTile(
                          title: Text('Drugs'),
                          subtitle:  Container(
                            height: 100,// Set the height as needed
                            child: ListView.builder(
                              itemCount: drugs.length,
                              itemBuilder: (context, index) {
                                return Text(drugs[index]);
                              },
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Chronic Diseases'),
                          subtitle:  Container(
                            height: 100,// Set the height as needed
                            child: ListView.builder(
                              itemCount: diseases.length,
                              itemBuilder: (context, index) {
                                return Text(diseases[index]);
                              },
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text('Blood Type'),
                          subtitle:
                          Text("O+"), // Use 'email' key
                        ),
                        // Add more patient data as needed
                      ],
                    ),
                  ),
                ),
                  Row(
                    children:[
                      ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditPatientInfoPage()),
                      );
                    },
                    child: const Text('Edit Patient Info'),
                  ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditMedicalInfoPage()),
                          );
                        },
                        child: const Text('Edit Medical Info'),
                      ),
                    ]
                  )
                ],

              ));
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text("No data");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
