import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/admin/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminStatisticsPage extends StatefulWidget {
  AdminStatisticsPage({Key? key}) : super(key: key);

  @override
  _AdminStatisticsPageState createState() => _AdminStatisticsPageState();
}

class _AdminStatisticsPageState extends State<AdminStatisticsPage> {
  late Future<Map<String, int>> monthlyAppointments;
  late Future<Map<String, int>> dailyAppointments;
  late Future<Map<String, int>> weeklyAppointments;
  late Future<Map<String, int>> userStatistics;

  @override
  void initState() {
    super.initState();
    monthlyAppointments = fetchAppointments('MM');
    dailyAppointments = fetchAppointments('dd');
    weeklyAppointments = fetchAppointments('w');
    userStatistics = fetchUserStatistics();
  }

  Future<Map<String, int>> fetchAppointments(String format) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('appointments').get();

    Map<String, int> counts = {};

    for (var doc in snapshot.docs) {
      DateTime date = (doc['date'] as Timestamp).toDate();
      String timePeriod = DateFormat('yyyy-' + format).format(date); // Include the year in the format

      if (counts.containsKey(timePeriod)) {
        counts[timePeriod] = counts[timePeriod]! + 1;
      } else {
        counts[timePeriod] = 1;
      }
    }

    return counts;
  }

  Future<Map<String, int>> fetchUserStatistics() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();

    Map<String, int> counts = {
      'doctors': 0,
      'patients': 0,
      'male': 0,
      'female': 0,
    };

    for (var doc in snapshot.docs) {
      String role = doc['role'];
      String gender = doc['gender'];

      if (role == 'doctor') {
        counts['doctors'] = counts['doctors']! + 1;
      } else if (role == 'patient') {
        counts['patients'] = counts['patients']! + 1;
      }

      if (gender == 'male') {
        counts['male'] = counts['male']! + 1;
      } else if (gender == 'female') {
        counts['female'] = counts['female']! + 1;
      }
    }

    return counts;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder<Map<String, int>>(
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
                child: ChartWidget(
                  title: 'Monthly Appointments',
                  monthlyAppointments: monthlyCounts,
                ),
              );
            }
          },
        ),
        FutureBuilder<Map<String, int>>(
          future: dailyAppointments,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Map<String, int> dailyCounts = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ChartWidget(
                  title: 'Daily Appointments',
                  monthlyAppointments: dailyCounts,
                ),
              );
            }
          },
        ),
        FutureBuilder<Map<String, int>>(
          future: userStatistics,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Map<String, int> userCounts = snapshot.data!;
              Map<String, int> roleCounts = {
                'doctors': userCounts['doctors']!,
                'patients': userCounts['patients']!,
              };
              Map<String, int> genderCounts = {
                'male': userCounts['male']!,
                'female': userCounts['female']!,
              };
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ChartWidget(
                      title: 'User Roles',
                      monthlyAppointments: roleCounts,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ChartWidget(
                      title: 'User Genders',
                      monthlyAppointments: genderCounts,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}