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


  const AppointmentFullInformationScreen({super.key, required this.appointmentId, required this.patientName});

  @override
  State<AppointmentFullInformationScreen> createState() =>
      _AppointmentFullInformationScreenState();
}

class _AppointmentFullInformationScreenState
    extends State<AppointmentFullInformationScreen> {
  late Future<DocumentSnapshot> appointmentData;
  late Future<DocumentSnapshot> userData;
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
          future: Future.wait([appointmentData, userData]),
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
            },);
            },
              );
            }
          },
        ),
      ),
    );
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
            ElevatedButton(
              onPressed: onDiagnosePressed,
              child: const Text("Diagnose"),
            ),
          ],
        ),
      ),
    );
  }
}