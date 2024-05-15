import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  final String title;
  final Map<String, int> monthlyAppointments;

  const ChartWidget({
    super.key,
    required this.title,
    required this.monthlyAppointments,
  });

  List<OrdinalData> getData() {
    List<OrdinalData> ordinalList = [];

    monthlyAppointments.forEach((key, value) {
      ordinalList.add(OrdinalData(
        domain: key,
        measure: value,
      ));
    });

    return ordinalList;
  }

  @override
  Widget build(BuildContext context) {
    final ordinalGroup = [
      OrdinalGroup(
        id: '1',
        chartType: ChartType.bar,
        data: getData(),
      ),
      OrdinalGroup(
        id: '2',
        chartType: ChartType.line,
        data: getData(),
      ),
      OrdinalGroup(
        id: '3',
        chartType: ChartType.scatterPlot,
        data: getData(),
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.white,
        // shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 250,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: DChartComboO(
                groupList: ordinalGroup,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
