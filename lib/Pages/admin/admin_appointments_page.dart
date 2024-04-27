import 'package:flutter/material.dart';

import 'admin_appointment_details_page.dart';
import 'widgets/admin_appointment_card.dart';

class AdminAppointmentsPage extends StatelessWidget {
  AdminAppointmentsPage({super.key});

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
    return ListView.builder(
      itemCount: allAppointments.length,
      itemBuilder: (context, index) {
        var appointment = allAppointments[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AdminAppointmentDetailsPage(appointment: appointment),
              ),
            );
          },
          child: AdminAppointmentCard(
            appointment: appointment,
          ),
        );
      },
    );
  }
}
