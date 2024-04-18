import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/Appointment_Details.dart';
class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final DateTime dateTime;

  const AppointmentCard({super.key, 
    required this.doctorName,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(doctorName),
        subtitle:
            Text('Date: ${dateTime.day}/${dateTime.month}/${dateTime.year}\n'
                'Time: ${dateTime.hour}:${dateTime.minute}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                  const AppointmentDetailsPage()), // Navigate to CreateAppointmentPage
          );
        },
      ),
    );
  }
}
