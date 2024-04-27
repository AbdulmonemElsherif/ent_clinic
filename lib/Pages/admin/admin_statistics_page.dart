import 'package:ent_clinic/Pages/admin/widgets/chart_widget.dart';
import 'package:flutter/material.dart';

class AdminStatisticsPage extends StatelessWidget {
  AdminStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          // Add StatisticsWidget here
          ChartWidget(
            title: '(1st Quarter)',
            monthlyAppointments: {
              'Jan': 150,
              'Feb': 55,
              'March': 13,
            },
          ),
          ChartWidget(
            title: "(2nd Quarter)",
            monthlyAppointments: {
              'April': 48,
              'May': 20,
              'June': 90,
            },
          ),
          ChartWidget(
            title: "(3rd Quarter)",
            monthlyAppointments: {
              'July': 80,
              'August': 175,
              'September': 80,
            },
          ),
          ChartWidget(
            title: "(4th Quarter)",
            monthlyAppointments: {
              'October': 20,
              'November': 44,
              'December': 210,
            },
          ),
        ],
      ),
    );
  }
}
