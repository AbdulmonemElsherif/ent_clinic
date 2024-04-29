import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/doctor_2.png',
                  width: 45,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dr. Ruben Dorwart",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text("Specialist", style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 8.0,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(
                  Ionicons.calendar_outline,
                  size: 18,
                  color: Colors.black87,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6, right: 14),
                  child: Text(
                    "Today",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Ionicons.time_outline,
                    size: 18,
                  ),
                ),
                Expanded( // Add this
                  child: Text(
                    "14:30 - 15:30 AM",
                    style: TextStyle(),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded( // Add this
                child: SizedBox(
                  height: 32,
                  child: OutlinedButton(
                    onPressed: () {}, 
                    child: const Text("Cancel")
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded( // Add this
                child: SizedBox(
                  height: 32,
                  child: OutlinedButton(
                    onPressed: () {}, 
                    child: const Text("Reschedule")
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}