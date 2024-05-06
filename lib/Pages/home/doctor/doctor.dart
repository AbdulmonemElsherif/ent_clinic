import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/home/doctor/doctor_drawer.dart';
import 'package:ent_clinic/Pages/home/doctor/doctor_profile.dart';
import 'package:ent_clinic/Pages/home/doctor/patientInfo.dart';
import 'package:ent_clinic/Pages/home/patient/home/home_drawer.dart';
import 'package:ent_clinic/core/GeneralWidgets/CustomTextBox.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
class DoctorPage extends StatefulWidget {
  DoctorPage({Key? key}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<QueryDocumentSnapshot>> fetchDoctors() async {
    final QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'doctor')
        .get();
    return snapshot.docs;
  }
  Future<String> fetchPatientName(String patientId) async {
    final DocumentSnapshot snapshot = await _firestore
        .collection('users')
        .doc(patientId)
        .get();
    return snapshot['name'];
  }
    
  Future<List<QueryDocumentSnapshot>> fetchAppointments() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw Exception('No user is currently logged in');
    }
    print('Current user ID: ${currentUser.uid}'); // Debugging line

    final QuerySnapshot snapshot = await _firestore
        .collection('appointments')
        .where('doctorID', isEqualTo: currentUser.uid)
        .where('approvalStatus', isEqualTo: 'accepted')
        .get();

    print('Fetched appointments: ${snapshot.docs}'); // Debugging line

    return snapshot.docs;
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

   
   return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Dashboard'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          drawer: const DoctorDrawer(),
          body: Column(
            children: [
              const DoctorInfoCard(),
              const Divider(),
              TabBar(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Appointments'),
                  Tab(text: 'History'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Appointments tab
                    FutureBuilder<List<QueryDocumentSnapshot>>(
                      future: fetchAppointments(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final doc = snapshot.data![index];
                              return FutureBuilder<String>(
                                future: fetchPatientName(doc['patient']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Card(
                                      child: ListTile(
                                        title: Text(snapshot.data ?? 'No name'),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Appointment on ${DateFormat('yyyy-MM-dd h:mm a').format(doc['date'].toDate())}'),
                                            Text('Complaint: ${doc['complaint']}'),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const PatientInfo(),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.arrow_forward),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                    // History tab
                    Center(
                      child: Text('History tab content goes here'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorInfoCard extends StatelessWidget {
  const DoctorInfoCard({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> fetchDoctorDetails() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw Exception('No user is currently logged in');
    }

    final DocumentSnapshot snapshot = await _firestore
        .collection('users')
        .doc(currentUser.uid)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchDoctorDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final doc = snapshot.data!;
          return Card(
            color: (Theme.of(context).brightness == Brightness.light)
                ? const Color(0xFFC8E6FF)
                : const Color(0xFF004C6E),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 18),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DoctorProfile(),
                ),
              ),
              title: Text(
                "Hello! ${doc['name']}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${doc['Speciality']}",
                style: TextStyle(fontSize: 15),
              ),
            ),
          );
        }
      },
    );
  }
}
class AssignedAppointments extends StatelessWidget {
  const AssignedAppointments(
      {super.key,
      required this.name,
      required this.date,
      required this.imagepath,
      required this.time});
  final String name;
  final String date;
  final String time;
  final String imagepath;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: (Theme.of(context).brightness == Brightness.light)
          ? const Color(0xFFC8E6FF)
          : const Color(0xFF004C6E),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: [
            Column(
              children: [
                RegularText(text: date),
                RegularText(text: time),
              ],
            ),
            const Gap(20),
            RegularText(
              text: "Patient : $name",
              fontsize: 20,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatientInfo(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward))
          ],
        ),
      ),
    );
  }
}
