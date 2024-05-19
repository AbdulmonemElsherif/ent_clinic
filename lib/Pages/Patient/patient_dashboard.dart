import 'package:ent_clinic/Pages/appointment/create_appointment_page.dart';
import 'package:ent_clinic/Pages/home/patient/home/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ent_clinic/Pages/Patient/appointment_card.dart';
import 'package:ent_clinic/Pages/Patient/history_appointment_card.dart';

class PatientDashboardPage extends StatefulWidget {
  const PatientDashboardPage({Key? key}) : super(key: key);

  @override
  _PatientDashboardPageState createState() => _PatientDashboardPageState();
}

class _PatientDashboardPageState extends State<PatientDashboardPage> {
  int activeIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Stream<QuerySnapshot> historyData;

  @override
  void initState() {
    super.initState();
    historyData = FirebaseFirestore.instance
        .collection('history')
        .where('patient', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
Future<List<QueryDocumentSnapshot>> fetchHistory() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('history')
      .where('patient', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
  return querySnapshot.docs;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const HomeDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CupertinoSlidingSegmentedControl(
            padding: const EdgeInsets.all(5),
            groupValue: activeIndex,
            children: const {
              0: Text("Appointments"),
              1: Text("Med History"),
            },
            onValueChanged: (value) {
              setState(() {
                activeIndex = value!;
              });
            },
          ),
          if (activeIndex == 0) ...[
            const SizedBox(height: 25),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('appointments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return Column(
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    if (doc['patient'] == FirebaseAuth.instance.currentUser!.uid) {
                      return AppointmentCard(appointment: doc);
                    } else {
                      return Container();
                    }
                  }).toList(),
                );
              },
            ),
          ],
          if (activeIndex == 1) ...[
            const SizedBox(height: 25),
            FutureBuilder<List<QueryDocumentSnapshot>>(
              future: fetchHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    children: snapshot.data!.map((QueryDocumentSnapshot doc) {
                      return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: HistoryAppointmentCard(historyData: doc),
    );
  }).toList(),
                  );
                }
              },
            ),
          ],
        ],
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(bottom: 80.0, right: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateAppointmentPage(
                    patient: FirebaseAuth.instance.currentUser!.uid),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}