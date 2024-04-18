import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final DateTime dateTime;

  const AppointmentCard({
    required this.doctorName,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(doctorName),
        subtitle: Text(
            'Date: ${dateTime.day}/${dateTime.month}/${dateTime.year}\n'
            'Time: ${dateTime.hour}:${dateTime.minute}'
        ),
        onTap: () {
          // Navigate to appointment details screen
        },
      ),
    );
  }
}
