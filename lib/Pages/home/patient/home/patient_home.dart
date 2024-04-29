import 'package:ent_clinic/Pages/appointment/create_appointment_page.dart';
import 'package:ent_clinic/Pages/prescription/create_prescription_page.dart';
import 'package:flutter/material.dart';
import 'home_drawer.dart';
import 'appointment_card.dart';
import 'prescription_card.dart'; // Import PrescriptionCard widget// Import CreatePrescriptionPage widget
import 'package:firebase_auth/firebase_auth.dart';

class Appointment {
  final String doctorName;
  final DateTime dateTime;

  Appointment(this.doctorName, this.dateTime);
}

class Prescription {
  final String medicine;
  final String dosage;

  Prescription(this.medicine, this.dosage);
}

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Appointment> appointments = [
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
  ];

  final List<Prescription> prescriptions = [
    Prescription('Medicine A', '1 pill daily'),
    Prescription('Medicine B', '2 pills twice a day'),
    Prescription('Medicine C', '3 pills before meals'),
    Prescription('Medicine A', '1 pill daily'),
    Prescription('Medicine B', '2 pills twice a day'),
    Prescription('Medicine C', '3 pills before meals'),
    Prescription('Medicine A', '1 pill daily'),
    Prescription('Medicine B', '2 pills twice a day'),
    Prescription('Medicine C', '3 pills before meals'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Sus Clinic'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const HomeDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Upcoming Appointments',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: appointments.length,
              itemBuilder: (BuildContext context, int index) {
                return AppointmentCard(
                  doctorName: appointments[index].doctorName,
                  dateTime: appointments[index].dateTime,
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Prescriptions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: prescriptions.map((prescription) {
                  return PrescriptionCard(
                    medicine: prescription.medicine,
                    dosage: prescription.dosage,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                   builder: (context) => CreateAppointmentPage(patient: FirebaseAuth.instance.currentUser!.uid),
                ),
              );
            },
            backgroundColor: Colors.blue,
            elevation: 2.0,
            child: const Icon(Icons.schedule),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreatePrescriptionPage()),
              );
            },
            backgroundColor: Colors.green,
            elevation: 2.0,
            child: const Icon(Icons.local_hospital),
          ),
        ],
      ),
    );
  }
}
