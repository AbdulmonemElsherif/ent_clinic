import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class AppointmentCard extends StatelessWidget {
  final DocumentSnapshot appointment;

  const AppointmentCard({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = appointment['date'];
    DateTime date = timestamp.toDate();
    String formattedDate = DateFormat.yMMMMd().add_jm().format(date);
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16), // Adjust the spacing as needed
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
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
                      Text(
                        appointment['doctor'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        appointment['reason'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'Status: ${appointment['approvalStatus']}', // Display the appointment status
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
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
                  const Icon(
                    Ionicons.calendar_outline,
                    size: 18,
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, right: 14),
                    child: Text(
                      formattedDate,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Ionicons.time_outline,
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${appointment['time']}',
                      style: const TextStyle(),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 32,
                    child: OutlinedButton(
                        onPressed: () async {
                          // Delete the appointment from Firestore
                          await FirebaseFirestore.instance
                              .collection('appointments')
                              .doc(appointment.id)
                              .delete();
                        },
                        child: const Text("Cancel")),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
