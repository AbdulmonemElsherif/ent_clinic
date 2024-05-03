import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/admin/api.dart';
import 'package:flutter/material.dart';

import 'admin_appointment_details_page.dart';
import 'widgets/admin_appointment_card.dart';

class AdminAppointmentsPage extends StatelessWidget {
  AdminAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getAppointments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> allAppointments = snapshot.data!.docs
              .map((doc) {
                Map<String, dynamic> appointment = doc.data() as Map<String, dynamic>;
                appointment['id'] = doc.id; // Add the document ID to the appointment map
                return appointment;
              })
              .toList();

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
      },
    );
  }
}