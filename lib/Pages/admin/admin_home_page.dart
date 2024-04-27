import 'package:ent_clinic/Pages/admin/widgets/list_of_appointments.dart';
import 'package:ent_clinic/core/widgets/welcome_back_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/chart_widget.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({super.key});

  final List<Map<String, dynamic>> allAppointments = [
    {
      'id': '1',
      'doctorfname': 'Jane',
      'doctorlname': 'Smith',
      'doctorimage':
          'assets/doctor1.png', // Replace with your asset or network image path
      'userfname': 'John',
      'userlname': 'Doe',
      'userimage':
          'assets/user1.png', // Replace with your asset or network image path
      'userdicescess': 'Common Cold',
      'date': '2024-04-30',
      'time': '10:00 AM',
      'type': 'Checkup',
      'userbloodtype': 'A+',
    },
    {
      'id': '2',
      'doctorfname': 'Emily',
      'doctorlname': 'Brown',
      'doctorimage':
          'assets/doctor2.png', // Replace with your asset or network image path
      'userfname': 'Jane',
      'userlname': 'Doe',
      'userimage':
          'assets/user2.png', // Replace with your asset or network image path
      'userdicescess': 'Allergies',
      'date': '2024-05-01',
      'time': '11:00 AM',
      'type': 'Routine Visit',
      'userbloodtype': 'B+',
    },
    {
      'id': '3',
      'doctorfname': 'Luke',
      'doctorlname': 'White',
      'doctorimage':
          'assets/doctor3.png', // Replace with your asset or network image path
      'userfname': 'Bob',
      'userlname': 'Ross',
      'userimage':
          'assets/user3.png', // Replace with your asset or network image path
      'userdicescess': 'Back Pain',
      'date': '2024-05-02',
      'time': '09:00 AM',
      'type': 'Consultation',
      'userbloodtype': 'O-',
    },
    // Add more appointments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const WelcomeBackHeader(
          userName: "Jack Doeson",
          imagePath:
              'https://bodyinmotion.co.nz/wp-content/uploads/2018/07/placeholder-img-min.jpg',
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ListOfAppointments(appointments: allAppointments),
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
