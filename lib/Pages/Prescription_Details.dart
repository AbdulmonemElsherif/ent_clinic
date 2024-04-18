import 'package:flutter/material.dart';

class PrescriptionPage extends StatelessWidget {
  final String medicine;
  final String dosage;

  const PrescriptionPage({
    Key? key,
    required this.medicine,
    required this.dosage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medicine: $medicine',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dosage: $dosage',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // Add more details or actions related to the prescription here
          ],
        ),
      ),
    );
  }
}
