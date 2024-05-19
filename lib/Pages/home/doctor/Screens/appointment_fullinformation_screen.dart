import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/home/doctor/appointments%20widgets/diagnose_dialog.dart';
import 'package:ent_clinic/Pages/home/doctor/doctorHomeScreen%20widgets/doctor_drawer.dart';
import 'package:ent_clinic/Pages/home/doctor/appointments%20widgets/appointment_card.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AppointmentFullInformationScreen extends StatefulWidget {
  final String appointmentId;
  final String patientName;
  final String patientId;

  const AppointmentFullInformationScreen({super.key, required this.appointmentId, required this.patientName, required this.patientId});

  @override
  State<AppointmentFullInformationScreen> createState() =>
      _AppointmentFullInformationScreenState();
}

class _AppointmentFullInformationScreenState
    extends State<AppointmentFullInformationScreen> {
  late Future<DocumentSnapshot> appointmentData;
  late Future<DocumentSnapshot> userData;
  late Future<DocumentSnapshot> patientMedicalInfo; // Add this line
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    appointmentData = FirebaseFirestore.instance
        .collection('appointments')
        .doc(widget.appointmentId)
        .get();
    userData = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    patientMedicalInfo = FirebaseFirestore.instance // Add these lines
        .collection('users')
        .doc(widget.patientId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Dashboard'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: const DoctorDrawer(),
        body: FutureBuilder(
          future: Future.wait([appointmentData, userData, patientMedicalInfo]), // Update this line
          builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return AppointmentFullinformationCard(
                name: widget.patientName,
                date: snapshot.data![0]['date'].toDate().toString(),
                imagepath: "assets/images/profilepic.jpg",
                time: snapshot.data![0]['time'],
                complaint: snapshot.data![0]['complaint'],
                userId: userId,
                userName: snapshot.data![1]['name'],
                patientId: snapshot.data![0]['patient'],
                smoker: snapshot.data![2]['smoker'], // Add these lines
                specialMedicalHabits: snapshot.data![2]['specialMedicalHabits'],
                chronicDiseases: snapshot.data![2]['chronicDiseases'].join(', '),
                drugs: snapshot.data![2]['drugs'].join(', '),
                bloodType: snapshot.data![2]['bloodType'],
                allergies: snapshot.data![2]['allergies'].join(', '),
                onDiagnosePressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DiagnoseDialoge(
                        doctorId: userId,
                        doctorName: snapshot.data![1]['name'],
                        patientId: snapshot.data![0]['patient'],
                        patientName: widget.patientName,
                      );
                    },
                  ).then((diagnosis) {
                    // After the dialog is dismissed, diagnose the appointment and move it to history
                    if (diagnosis != null) {
                      diagnoseAndMoveToHistory(widget.appointmentId, diagnosis);
                    }
                  });
                },
              );
            }
          },
        ),
      ),
    );
  }
  
  void diagnoseAndMoveToHistory(String appointmentId, Map<String, dynamic> diagnosis) async {
    // Add the diagnosis to the diagnoses collection
    await FirebaseFirestore.instance
        .collection('diagnoses')
        .doc(appointmentId)
        .set(diagnosis);
  
    // Get the appointment data
    DocumentSnapshot appointment = await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId)
        .get();
  
    // Add the appointment to the history collection with a 'diagnosed' field
    await FirebaseFirestore.instance
        .collection('history')
        .doc(appointmentId)
        .set({...appointment.data() as Map<String, dynamic>, 'diagnosed': true});
  
    // Delete the appointment from the appointments collection
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId)
        .delete();
  }
    }
class AppointmentFullinformationCard extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final String imagepath;
  final String complaint;
  final String userId;
  final String userName;
  final String patientId;
  final String smoker; // Add these lines
  final String specialMedicalHabits;
  final String chronicDiseases;
  final String drugs;
  final String bloodType;
  final String allergies;
  final VoidCallback onDiagnosePressed;

  const AppointmentFullinformationCard({
    Key? key,
    required this.name,
    required this.date,
    required this.imagepath,
    required this.time,
    required this.complaint,
    required this.userId,
    required this.userName,
    required this.patientId,
    required this.smoker, // Add these lines
    required this.specialMedicalHabits,
    required this.chronicDiseases,
    required this.drugs,
    required this.bloodType,
    required this.allergies,
    required this.onDiagnosePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(imagepath),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Patient",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        "$name",
                        style: const TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(date))}",
              style: const TextStyle(fontSize: 16),
            ),
            Text("Time: $time", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              'Complaints',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text(
              complaint,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 20),
            const Text(
              'Medical Information',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text("Smoker: $smoker", style: const TextStyle(fontSize: 16)),
            Text("Special Medical Habits: $specialMedicalHabits", style: const TextStyle(fontSize: 16)),
            Text("Chronic Diseases: $chronicDiseases", style: const TextStyle(fontSize: 16)),
            Text("Drugs: $drugs", style: const TextStyle(fontSize: 16)),
            Text("Blood Type: $bloodType", style: const TextStyle(fontSize: 16)),
            Text("Allergies: $allergies", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiagnoseDialoge(
                    doctorId: userId,
                    doctorName: userName,
                    patientId: patientId,
                    patientName: name,
                  )),
                );
              },
              child: const Text("Diagnose"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'refresh');
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}