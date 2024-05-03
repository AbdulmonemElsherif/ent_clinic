import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/admin/widgets/chart_widget.dart';
import 'package:flutter/material.dart';

class AdminStatisticsPage extends StatefulWidget {
  AdminStatisticsPage({Key? key}) : super(key: key);

  @override
  _AdminStatisticsPageState createState() => _AdminStatisticsPageState();
}

class _AdminStatisticsPageState extends State<AdminStatisticsPage> {
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
    return FutureBuilder<Map<String, int>>(
      future: monthlyAppointments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, int> monthlyCounts = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ChartWidget(
                  title: 'Monthly Appointments',
                  monthlyAppointments: monthlyCounts,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}