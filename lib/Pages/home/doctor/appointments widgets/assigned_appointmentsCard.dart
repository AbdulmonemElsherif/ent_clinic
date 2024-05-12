import 'package:ent_clinic/Pages/home/doctor/Screens/appointment_fullinformation_screen.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AssignedAppointmentCard extends StatelessWidget {
  const AssignedAppointmentCard(
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
                      builder: (context) =>
                         Container()
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
