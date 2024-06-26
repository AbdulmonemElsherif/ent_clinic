import 'package:ent_clinic/Pages/admin/api.dart';
import 'package:flutter/material.dart';

class AdminAppointmentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AdminAppointmentDetailsPage({super.key, required this.appointment});

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
          return Scaffold(
            appBar: AppBar(
              title: Text('Appointment Details - ID: ${appointment['id']}'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //id
                  ListTile(
                    title: Text('ID: ${appointment['id']}'),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(appointment['doctor']),
                    ),
                    title: Text('Dr. ${appointment['doctor']}'),
                    subtitle: const Text('Specialist'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Logic to edit doctor details
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("appointment['userimage']"),
                    ),
                    title: Text(
                        '${snapshot.data?['patient'] ?? 'Unknown Patient'}'),
                    subtitle: Text(appointment['complaint']),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Logic to edit patient details
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Appointment Information',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 10),
                        InformationRow(
                          'Date:',
                          "${(appointment['date']).toDate().year}-${(appointment['date']).toDate().month}-${(appointment['date']).toDate().day}",
                        ),
                        InformationRow('Time:', '${appointment['time']}'),
                        InformationRow('Reason:', appointment['reason']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class InformationRow extends StatelessWidget {
  final String label;
  final String value;

  const InformationRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}
