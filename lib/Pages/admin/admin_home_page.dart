import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/admin/api.dart';
import 'package:ent_clinic/Pages/admin/widgets/add_btn.dart';
import 'package:ent_clinic/Pages/admin/widgets/list_of_appointments.dart';
import 'package:ent_clinic/core/routes/routes.dart';
import 'package:ent_clinic/core/widgets/welcome_back_header.dart';
import 'package:flutter/material.dart';

import 'widgets/chart_widget.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late Future<Map<String, int>> monthlyAppointments;

  @override
  void initState() {
    super.initState();
    monthlyAppointments = fetchMonthlyAppointments();
  }

  Future<Map<String, int>> fetchMonthlyAppointments() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('appointments').get();

    Map<String, int> monthlyCounts = {};

    for (var doc in snapshot.docs) {
      DateTime date = (doc['date'] as Timestamp).toDate();
      String month = date.month.toString();

      if (monthlyCounts.containsKey(month)) {
        monthlyCounts[month] = monthlyCounts[month]! + 1;
      } else {
        monthlyCounts[month] = 1;
      }
    }

    return monthlyCounts;
  }

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
                          const SizedBox(height: 12),
                          FutureBuilder<Map<String, int>>(
                            future: monthlyAppointments,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                Map<String, int> monthlyCounts = snapshot.data!;
                                return ChartWidget(
                                  title: 'Monthly Appointments',
                                  monthlyAppointments: monthlyCounts,
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          const AddBtn(
                            label: 'Admin',
                            route: AppRoutes.addAdmin,
                          ),
                          const SizedBox(height: 12),
                          const AddBtn(
                            label: 'Doctor',
                            route: AppRoutes.addDoctor,
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