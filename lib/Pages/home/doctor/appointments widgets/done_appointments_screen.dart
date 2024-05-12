import 'package:ent_clinic/Pages/home/doctor/Screens/appointment_fullinformation_screen.dart';
import 'package:ent_clinic/Pages/home/doctor/appointments%20widgets/diagnose_dialog.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoneAppointmentFullinformation extends StatelessWidget {
  const DoneAppointmentFullinformation(
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
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(30),
        Card(
          color: (Theme.of(context).brightness == Brightness.light)
              ? const Color(0xFFC8E6FF)
              : const Color(0xFF004C6E),
          // color: const Color.fromARGB(255, 11, 79, 215),
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
                              'I\'ve noticed a persistent cough that hasn\'t improved with over-the-counter medication.\n',
                              style: TextStyle(
                                  fontSize: 16, overflow: TextOverflow.visible),
                              // Adjust font size as needed
                            ),
                            Row(
                              children: [
                                Textbuttoncontainer(
                                    text: "Diagnose",
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container();
                                        },
                                      );
                                    })

                                // GestureDetector(
                                //   child:

                                //   Container(
                                //     padding: const EdgeInsets.all(20),
                                //     decoration: BoxDecoration(
                                //         color: Colors.blue,
                                //         borderRadius:
                                //             BorderRadius.circular(20)),

                                //     // color: Colors.amber,
                                //     child: const Text("Diagnose"),
                                //   ),
                                //   onTap: () {
                                //     showDialog(
                                //       context: context,
                                //       builder: (BuildContext context) {
                                //         return const DiagnoseDialoge();
                                //       },
                                //     );
                                //   },
                                // )
                              ],
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
