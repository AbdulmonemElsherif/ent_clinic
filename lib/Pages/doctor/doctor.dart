import 'package:ent_clinic/Pages/home/patient/home/appointment_card.dart';
import 'package:ent_clinic/core/GeneralWidgets/CustomTextBox.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Doctor extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Doctor({Key? key});

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
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      {
        "name": "Hitler",
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      {
        "name": "Hitler",
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      {
        "name": "Hitler",
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      {
        "name": "Hitler",
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      {
        "name": "Hitler",
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      {
        "name": "Hitler",
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      {
        "name": "Hitler",
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      {
        "name": "Hitler",
        "date": "25/4/2024",
        "imagepath": "assets/images/profilepic.jpg",
        "time": "3:00 PM",
      },
      // Add more appointments as needed
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const DoctorInfoCard(),
            const Gap(100),
            Expanded(
              child: Container(
                // color: Color,
                color: Colors.white10,
                child: ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    // Extract appointment data for the current index
                    Map<String, String> appointment = appointments[index];

                    return AssignedAppointments(
                      name: appointment["name"] ?? "",
                      date: appointment["date"] ?? "",
                      imagepath: appointment["imagepath"] ?? "",
                      time: appointment["time"] ?? "",
                    );
                  },
                ),
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
      // shape: ,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
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
                RegularText(text: "Dr. " "Hossam Yasser"),
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                      return const CHangePassswordDialog();
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
      surfaceTintColor: Colors.black87,
      backgroundColor: const Color.fromARGB(221, 0, 0, 0),
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
