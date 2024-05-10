import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      required this.title,
      required this.data,
      required this.fields,
      required this.listFields});

  final String title;
  final Map<String, dynamic> data;
  final List<String> fields;
  final Map<String, List<dynamic>?> listFields;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...fields.map((field) => ListTile(
                    title: Text(field),
                    subtitle: Text(data[field] ?? 'N/A'),
                  )),
              ...listFields.entries.map((entry) => ListTile(
                    title: Text(entry.key),
                    subtitle: _buildList(entry.value),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildList(List<dynamic>? items) {
  if (items == null || items.isEmpty) {
    return const Text('N/A');
  }
  return ListView.builder(
    shrinkWrap: true,
    itemCount: (items.length),
    itemBuilder: (context, index) {
      return Text(items[index]);
    },
  );
}
