import 'package:flutter/material.dart';

class AdminAppointmentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AdminAppointmentDetailsPage({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details - ID: ${appointment['id']}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(appointment['doctorimage']),
              ),
              title: Text(
                  'Dr. ${appointment['doctorfname']} ${appointment['doctorlname']}'),
              subtitle: Text('Specialist'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Logic to edit doctor details
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(appointment['userimage']),
              ),
              title: Text(
                  '${appointment['userfname']} ${appointment['userlname']}'),
              subtitle: Text(appointment['userdicescess']),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Logic to edit patient details
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointment Information',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10),
                  InformationRow('Date:', appointment['date']),
                  InformationRow('Time:', appointment['time']),
                  InformationRow('Type:', appointment['type']),
                  InformationRow('Blood Type:', appointment['userbloodtype']),
                ],
              ),
            ),
          ],
        ),
      ),
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
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}
