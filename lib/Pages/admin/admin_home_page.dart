import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/admin/api.dart';
import 'package:ent_clinic/Pages/admin/widgets/list_of_appointments.dart';
import 'package:ent_clinic/core/widgets/welcome_back_header.dart';
import 'package:flutter/material.dart';

import 'widgets/chart_widget.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getAdminName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String adminName = snapshot.data!;
          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: getPendingAppointments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> allAppointments = snapshot.data!;

                return ListView(
                  children: [
                    WelcomeBackHeader(
                      userName: adminName,
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
            },
          );
        }
      },
    );
  }
}