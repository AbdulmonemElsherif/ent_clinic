import 'package:ent_clinic/Pages/home/doctor/doctor_drawer.dart';
import 'package:ent_clinic/Pages/home/doctor/doctor_profile.dart';
import 'package:ent_clinic/Pages/home/doctor/patientInfo.dart';
// import 'package:ent_clinic/Pages/home/patient/home/appointment_card.dart';
import 'package:ent_clinic/Pages/home/patient/home/home_drawer.dart';
import 'package:ent_clinic/core/GeneralWidgets/CustomTextBox.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class DoctorPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DoctorPage({super.key});

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // Dummy appointment data

    List<Map<String, String>> appointments = [
      {
        "name": "Hitler",
        "date": "24/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "2:00 AM",
      },
      {
        "name": "Hitler",
        "date": "24/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "2:00 AM",
      },
      {
        "name": "Hitler",
        "date": "24/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "2:00 AM",
      },
      {
        "name": "Hitler",
        "date": "24/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "2:00 AM",
      },
      {
        "name": "Hitler",
        "date": "24/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "2:00 AM",
      },
      {
        "name": "Hitler",
        "date": "24/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "2:00 AM",
      },
    ];

    return SafeArea(
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
            const Gap(30),
            const DoctorInfoCard(),
            const Gap(20),
            const Gap(10),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController, // Provide the TabController
                    // Add labels for each tab
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.calendar_month),
                        text: 'Appointments',
                      ),
                      Tab(
                        icon: Icon(Icons.history),
                        text: 'History',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      // Wrap content with TabBarView
                      controller: _tabController,
                      children: [
                        ListView(
                          physics: const ClampingScrollPhysics(),
                          scrollDirection:
                              Axis.horizontal, // Horizontal scrolling
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: appointments.length,
                                itemBuilder: (context, index) {
                                  // Extract appointment data for the current index
                                  Map<String, String> appointment =
                                      appointments[index];

                                  return Column(
                                    children: [
                                      const Gap(5),
                                      AssignedAppointments(
                                        name: appointment["name"] ?? "",
                                        date: appointment["date"] ?? "",
                                        imagepath:
                                            appointment["imagepath"] ?? "",
                                        time: appointment["time"] ?? "",
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection:
                                Axis.horizontal, // Horizontal scrolling
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: appointments.length,
                                  itemBuilder: (context, index) {
                                    // Extract appointment data for the current index
                                    Map<String, String> appointment =
                                        appointments[index];

                                    return Column(
                                      children: [
                                        const Gap(5),
                                        AssignedAppointments(
                                          name: appointment["name"] ?? "",
                                          date: appointment["date"] ?? "",
                                          imagepath:
                                              appointment["imagepath"] ?? "",
                                          time: appointment["time"] ?? "",
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        //

                        // ListView(children: const [
                        //   Text('Content for Tab 2'),
                        //   Text('Content for Tab 2'),
                        //   Text('Content for Tab 2'),
                        //   Text('Content for Tab 2'),
                        // ]), // Placeholder for Tab 2 content
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorInfoCard extends StatelessWidget {
  const DoctorInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (Theme.of(context).brightness == Brightness.light)
          ? const Color(0xFFC8E6FF)
          : const Color(0xFF004C6E),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30, // Adjust the radius according to your preference
              backgroundImage: AssetImage("assets/images/profilepic.jpg"),
            ),
            const Gap(20),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DoctorProfile(),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  RegularText(text: "Hello!\nDr. " "Hossam Yasser"),
                  RegularText(
                    text: "otolaryngologist ",
                    fontsize: 15,
                  ),
                  const Gap(5),
                ],
              ),
            )
          ],
        ),
      ),
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
