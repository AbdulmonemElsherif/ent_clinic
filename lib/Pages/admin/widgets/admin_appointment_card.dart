import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/admin/api.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class AdminAppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  const AdminAppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: getUserName(appointment['patient'] as String),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              title: Text(
                appointment['doctor'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              subtitle: Text(
                'with ${snapshot.data?['patient'] ?? 'Unknown Patient'}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              leading: const CircleAvatar(child: Text('A')),
              elevation: 4,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appointment['doctor'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'with ${snapshot.data?['patient'] ?? 'Unknown Patient'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          appointment['approvalStatus'] == 'accepted' ||
                                  appointment['approvalStatus'] == 'rejected'
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                          Icons.check_circle_outline),
                                      color: Colors.green,
                                      onPressed: () {
                                        if (appointment['id'] != null) {
                                          setAppointmentStatusAccepted(
                                              appointment['id']);
                                        } else {
                                          print(
                                              'Error: appointment ID is null');
                                        }
                                      },
                                      tooltip: 'Accept Appointment',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.cancel_outlined),
                                      color: Colors.red,
                                      onPressed: () {
                                        if (appointment['id'] != null) {
                                          setAppointmentStatusRejected(
                                              appointment['id']);
                                        } else {
                                          print(
                                              'Error: appointment ID is null');
                                        }
                                      },
                                      tooltip: 'Cancel Appointment',
                                    ),
                                  ],
                                )
                        ,],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(appointment['date'] as Timestamp).toDate().year}-${(appointment['date'] as Timestamp).toDate().month}-${(appointment['date'] as Timestamp).toDate().day}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${appointment['time']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
