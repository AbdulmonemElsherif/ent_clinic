import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/Prescription_Details.dart';

class PrescriptionCard extends StatelessWidget {
  final String medicine;
  final String dosage;

  const PrescriptionCard({
    super.key,
    required this.medicine,
    required this.dosage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the prescription's page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrescriptionPage(
              medicine: medicine,
              dosage: dosage,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity, // Set a constant width for the card
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medicine: $medicine',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dosage: $dosage',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
