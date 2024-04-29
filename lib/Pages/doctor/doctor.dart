import 'package:ent_clinic/Pages/home/patient/home/appointment_card.dart';
import 'package:ent_clinic/core/GeneralWidgets/CustomTextBox.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DoctorPage({super.key});

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      {
        "name": "Hitler",
        "date": "24/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "2:00 AM",
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Gap(30),
            const DoctorInfoCard(),
            const Gap(20),
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 30),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: const Color(0xFF212121),
            //   ),
            //   // Removed IconButton row
            // ),
            const Gap(10),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController, // Provide the TabController
                    // Add labels for each tab
                    tabs: const [
                      Tab(icon: Icon(Icons.calendar_month)),
                      Tab(icon: Icon(Icons.history)),
                      Tab(icon: Icon(Icons.local_hospital)),
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
                        // ... other content for remaining tabs
                        const Text(
                            'Content for Tab 2'), // Placeholder for Tab 2 content
                        const Text(
                            'Content for Tab 3'), // Placeholder for Tab 3 content
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
      color: const Color.fromARGB(255, 11, 79, 215),
      // shape: ,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30, // Adjust the radius according to your preference
              backgroundImage: AssetImage("assets/images/profilepic.jpg"),
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText(text: "Hello!\nDr. " "Hossam Yasser"),
                RegularText(
                  text: "otolaryngologist ",
                  fontsize: 15,
                ),
              ],
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
      color: const Color.fromARGB(255, 11, 79, 215),
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
            // const CircleAvatar(
            //   radius: 22, // Adjust the radius according to your preference
            //   backgroundImage: AssetImage("assets/images/profilepic.jpg"),
            // ),
            // const Gap(15),
            RegularText(
              text: "Patient : $name",
              fontsize: 20,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AppointmentFullinformation(
                        name: name,
                        date: date,
                        imagepath: imagepath,
                        time: time,
                      );
                    },
                  );
                },
                icon: const Icon(Icons.arrow_forward))
          ],
        ),
      ),
    );
  }
}

// Appointment('Dr. John Doe', DateTime(2024, 4, 18, 10, 0))
//  Text('Date: ${dateTime.day}/${dateTime.month}/${dateTime.year}\n'
//                 'Time: ${dateTime.hour}:${dateTime.minute}'),
// class PatientInfoDialog extends StatelessWidget {
//   const PatientInfoDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Dialog();
//   }
// }

class CHangePassswordDialog extends StatefulWidget {
  const CHangePassswordDialog({
    super.key,
  });

  // final Future<void> Function(String, String) changePassword;
  @override
  State<CHangePassswordDialog> createState() => _CHangePassswordDialogState();
}

class _CHangePassswordDialogState extends State<CHangePassswordDialog> {
  final newPassword = TextEditingController();
  final newPasswordConfirmation = TextEditingController();
  final oldPassword = TextEditingController();

  String? passwodDialogErrorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // surfaceTintColor: Colors.black87,
      backgroundColor: const Color(0xFF000000),
      title: const Text('Change password'),
      contentPadding: const EdgeInsets.all(3),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(20),
          CustomTextBox(
            hintText: "Enter your old password",
            controller: oldPassword,
            isPassword: true,
            onChanged: (value) {},
            // backgroundColor: Colors.black,
          ),
          const Gap(20),
          CustomTextBox(
            hintText: "Enter your new password",
            controller: newPassword,
            isPassword: true,
            onChanged: (value) {},
          ),
          const Gap(20),
          CustomTextBox(
            hintText: "Confirm your password",
            controller: newPasswordConfirmation,
            isPassword: true,
            onChanged: (value) {},
          ),
          const Gap(15),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Update'),
        ),
      ],
    );
  }
}

class AppointmentFullinformation extends StatelessWidget {
  const AppointmentFullinformation(
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Gap(150),
        Card(
          color: const Color.fromARGB(255, 11, 79, 215),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius:
                          22, // Adjust the radius according to your preference
                      backgroundImage:
                          AssetImage("assets/images/profilepic.jpg"),
                    ),
                    const Gap(20),
                    RegularText(
                      text: "Patient Name: $name",
                      fontsize: 20,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(20),
                        RegularText(text: date),
                        RegularText(text: time),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        width: (MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width / 2.5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RegularText(
                              text: 'Complains',
                              fontsize: 30,
                            ),
                            const Gap(20),
                            const Text(
                              'I\'ve been experiencing a sharp pain in my lower right abdomen for the past few days\n'
                              'I\'ve noticed a persistent cough that hasn\'t improved with over-the-counter medication.\n'
                              'I feel a general feeling of fatigue and weakness, along with a slight fever.\n',
                              style: TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow
                                      .visible), // Adjust font size as needed
                            ),
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
