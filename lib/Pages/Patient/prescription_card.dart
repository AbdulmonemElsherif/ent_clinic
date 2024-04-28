import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PrescriptionCard extends StatelessWidget {
  const PrescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const Icon(
              Ionicons.medkit,
              size: 45,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Medicine A",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text("1 Pill Daily",
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          )
        ],
      ),
    );
  }
}
