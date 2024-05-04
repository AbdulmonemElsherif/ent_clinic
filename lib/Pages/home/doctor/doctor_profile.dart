import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/profile/edit_medical_info.dart';
import 'package:ent_clinic/Pages/profile/edit_patient_info.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  Future<DocumentSnapshot> getUserProfile(BuildContext context) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userProfile = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .get();

    if (!userProfile.exists) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EditMedicalInfoPage(documentId: firebaseUser.uid),
        ),
      );
      throw Exception('User profile does not exist');
    }

    return userProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getUserProfile(context),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                Map<String, dynamic>? data =
                    snapshot.data!.data() as Map<String, dynamic>?;
                if (data != null) {
                  String? bloodType = data['bloodType'];
                  List<dynamic>? chronicDiseases = data['chronicDiseases'];
                  List<dynamic>? drugs = data['drugs'];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // Patient Information Card
                        _buildCard(
                          title: 'Doctor Information',
                          data: data,
                          fields: ['name', 'DOB', 'gender', 'email', 'phone'],
                        ),
                        // Edit Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditPatientInfoPage()),
                                );
                              },
                              child: const Text('Edit Doctor Info'),
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     var firebaseUser =
                            //         FirebaseAuth.instance.currentUser;
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => EditMedicalInfoPage(
                            //             documentId: firebaseUser!.uid),
                            //       ),
                            //     );
                            //   },
                            //   child: const Text('Edit Medical Info'),
                            // ),
                          ],
                        )
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
    Map<String, List<dynamic>?>? listFields,
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
            ...fields.map((field) => ListTile(
                  title: Text(field),
                  subtitle: Text(data[field] ?? 'N/A'),
                )),
            if (listFields != null)
              ...listFields.entries.map((entry) => ListTile(
                    title: Text(entry.key),
                    subtitle: _buildList(entry.value),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<dynamic>? items) {
    if (items == null || items.isEmpty) {
      return const Text('N/A');
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Text(items[index]);
      },
    );
  }
}
