import 'package:ent_clinic/Pages/Patient/appointment_card.dart';
import 'package:ent_clinic/Pages/Patient/prescription_card.dart';
import 'package:ent_clinic/Pages/Patient/history_appointment_card.dart';
import 'package:ent_clinic/Pages/home/patient/home/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PatientDashboardPage extends StatefulWidget {
  const PatientDashboardPage({super.key});

  @override
  _PatientDashboardPageState createState() => _PatientDashboardPageState();
}

class _PatientDashboardPageState extends State<PatientDashboardPage> {
  int activeIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                2: Text("Prescription")
              },
              onValueChanged: (value) {
                setState(() {
                  activeIndex = value!;
                });
              },
            ),
            if (activeIndex == 0) ...[
              const SizedBox(height: 25),
              const AppointmentCard(),
              const SizedBox(height: 10),
              const AppointmentCard(),
              const SizedBox(height: 10),
              const AppointmentCard(),
              const SizedBox(height: 10),
              const AppointmentCard()
            ],
            if (activeIndex == 1) ...[
              const SizedBox(height: 25),
              const HistoryAppointmentCard(),
              const SizedBox(height: 10),
              const HistoryAppointmentCard(),
              const SizedBox(height: 10),
              const HistoryAppointmentCard(),
              const SizedBox(height: 10),
              const HistoryAppointmentCard()
            ],
            if (activeIndex == 2) ...[
              const SizedBox(height: 25),
              const PrescriptionCard(),
              const SizedBox(height: 10),
              const PrescriptionCard(),
              const SizedBox(height: 10),
              const PrescriptionCard(),
              const SizedBox(height: 10),
              const PrescriptionCard()
            ]
          ],
        ));
  }
}
