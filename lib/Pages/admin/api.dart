import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getAdminName() async {
  QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'admin')
      .get();
  return adminSnapshot.docs.first['name'];
}

Stream<QuerySnapshot<Object?>> getAppointments() {
  return FirebaseFirestore.instance.collection('appointments').snapshots();
}

Stream<List<Map<String, dynamic>>> getPendingAppointments() {
  return FirebaseFirestore.instance
      .collection('appointments')
      .where('approvalStatus', isEqualTo: "pending")
      .snapshots()
      .map((snapshot) => snapshot.docs.map((document) {
            Map<String, dynamic> appointment = document.data();
            appointment['id'] =
                document.id; // Add the document ID to the appointment map
            return appointment;
          }).toList());
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
  DocumentSnapshot patient =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  Map<String, String> doctorAndUser = {
    'patient': patient.get('name'),
  };

  return doctorAndUser;
}

Future<void> createDoctor({
  required String email,
  required String password,
  required String specialty,
  required String dob,
  required String gender,
  required String name,
  required String phone,
}) async {
  try {
    // Create a new user with the Firebase Authentication
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Add a new document to the users collection in the Firestore database
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': email,
      'role': 'doctor',
      'speciality': specialty,
      'dob': dob,
      'phone': phone,
      'name': name,
      'gender': gender,
    });

    print("Doctor created successfully.");
  } catch (e) {
    // Handle errors
    print("Error creating doctor: $e");
  }
}

Future<void> createAdmin({
  required String name,
  required String email,
  required String password,
  required String gender,
}) async {
  try {
    // Create a new user with the Firebase Authentication
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Add a new document to the users collection in the Firestore database
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': email,
      'role': 'admin',
      'name': name,
      'gender': gender,
    });

    print("Admin created successfully.");
  } catch (e) {
    // Handle errors
    print("Error creating admin: $e");
  }
}

Future<String> getDoctorSpecialization(String doctorId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot doc =
      await firestore.collection('users').doc(doctorId).get();

  if (doc.exists && doc['role'] == 'doctor') {
    return doc['Speciality'];
  } else {
    throw Exception('Doctor not found or user is not a doctor');
  }
}
