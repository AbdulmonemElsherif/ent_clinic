import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/admin/widgets/list_of_appointments.dart';
import 'package:ent_clinic/core/widgets/welcome_back_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/chart_widget.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, String>> appointments = [];

  Future<void> fetchAppointments() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('appointments')
        .where('status', isEqualTo: 'pending')
        .get();

    final List<Map<String, String>> fetchedAppointments = snapshot.docs.map(
      (doc) {
        final Map<String, String> entry = {
          'doctor': doc['doctor'],
          'date': doc['date'],
          'time': doc['time'].format(context),
          'reason': doc['reason'],
          'patient': doc['patient'],
          'complaint': doc['complaint'],
        };

        return entry;
      },
    ).toList();
    setState(
      () {
        appointments = fetchedAppointments;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const WelcomeBackHeader(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ListOfAppointments(appointments: appointments),
              const SizedBox(height: 10),
              const ChartWidget(
                title: 'Monthly Appointments',
                monthlyAppointments: {
                  '1st': 88,
                  '2nd': 76,
                  '3rd': 130,
                  '4th': 20,
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
