import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getAdminName() async {
  QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'admin')
      .get();
  return adminSnapshot.docs.first['name'];
}

Stream<QuerySnapshot> getAppointments() {
  return FirebaseFirestore.instance
      .collection('appointments')
      .snapshots();
}

Stream<QuerySnapshot> getPendingAppointments() {
  return FirebaseFirestore.instance
      .collection('appointments')
      .where('approvalStatus', isEqualTo: "pending")
      .snapshots();
}

Future<void> setAppointmentStatusAccepted(String appointmentId) async {
  try {
    // Reference to the Firestore collection
    var document = FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId);

    // Update the document
    await document.update({'approvalStatus': 'accepted'});
    print("Appointment status updated to accepted.");
  } catch (e) {
    // Handle errors
    print("Error updating appointment status: $e");
  }
}

Future<void> setAppointmentStatusRejected(String appointmentId) async {
  try {
    // Reference to the Firestore collection
    var document = FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId);

    // Update the document
    await document.update({'approvalStatus': 'rejected'});
    print("Appointment status updated to rejected.");
  } catch (e) {
    // Handle errors
    print("Error updating appointment status: $e");
  }
}

  Future<Map<String, String>> getUserName(String userId) async {
    DocumentSnapshot patient = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    Map<String, String> doctorAndUser = {
      'patient': patient.get('name'),
    };

    return doctorAndUser;
  }

