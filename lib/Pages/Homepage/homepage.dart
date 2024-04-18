import 'package:flutter/material.dart';
import 'HomeDrawer.dart'; // Import the HomeDrawer widget
import 'AppointmentCard.dart'; // Import the AppointmentCard widget
import '../CreateAppointmentPage.dart'; // Import the CreateAppointmentPage widget

// Custom data structure for appointments
class Appointment {
  final String doctorName;
  final DateTime dateTime;

  Appointment(this.doctorName, this.dateTime);
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Sample list of appointments (replace this with your actual data)
  final List<Appointment> appointments = [
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. Jane Smith', DateTime(2024, 4, 19, 14, 30)),
    Appointment('Dr. Emily Johnson', DateTime(2024, 4, 20, 11, 15)),
    Appointment('Dr. Michael Brown', DateTime(2024, 4, 21, 9, 0)),
    Appointment('Dr. Sarah White', DateTime(2024, 4, 22, 13, 45)),
    Appointment('Dr. William Black', DateTime(2024, 4, 23, 16, 30)),
    Appointment('Dr. Laura Green', DateTime(2024, 4, 24, 8, 30)),
    Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0)),
    Appointment('Dr. Jane Smith', DateTime(2024, 4, 19, 14, 30)),
    Appointment('Dr. Emily Johnson', DateTime(2024, 4, 20, 11, 15)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Clinic Name'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
        ),
      ),
      drawer: const HomeDrawer(), // Use HomeDrawer widget as the drawer
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (BuildContext context, int index) {
          return AppointmentCard(
            doctorName: appointments[index].doctorName,
            dateTime: appointments[index].dateTime,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateAppointmentPage()), // Navigate to CreateAppointmentPage
          );
        },
        child: Icon(Icons.add), // Plus icon
        backgroundColor: Colors.blue, // Set the background color
        elevation: 2.0, // Add elevation
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Center the button horizontally
    );
  }
}
