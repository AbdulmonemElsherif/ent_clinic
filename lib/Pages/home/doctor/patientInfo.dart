import 'dart:core';
import 'dart:core';

import 'package:ent_clinic/Pages/home/doctor/doctor_drawer.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({super.key});

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
          body: const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppointmentFullinformation(
                    name: "Hitler",
                    date: "24/4/2024",
                    imagepath: "assets/images/profilepic.jpg",
                    time: "2:00 AM",
                  ),
                  infoCard(
                    title: 'Medical Information',
                    data: {},
                    fields: ['smoker', 'specialMedicalHabits', 'bloodType'],
                    listFields: {
                      'drugs': [],
                      'chronicDiseases': [],
                      'allergies': [],
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class infoCard extends StatelessWidget {
  const infoCard(
      {super.key,
      required this.title,
      required this.data,
      required this.fields,
      required this.listFields});

  final String title;
  final Map<String, dynamic> data;
  final List<String> fields;
  final Map<String, List<dynamic>?> listFields;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...fields.map((field) => ListTile(
                    title: Text(field),
                    subtitle: Text(data[field] ?? 'N/A'),
                  )),
              ...listFields.entries.map((entry) => ListTile(
                    title: Text(entry.key),
                    subtitle: _buildList(entry.value),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildList(List<dynamic>? items) {
  if (items == null || items.isEmpty) {
    return const Text('N/A');
  }
  return ListView.builder(
    shrinkWrap: true,
    itemCount: (items.length),
    itemBuilder: (context, index) {
      return Text(items[index]);
    },
  );
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
                                          return const DiagnoseDialoge();
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
                                          return const DiagnoseDialoge();
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

class DiagnoseDialoge extends StatefulWidget {
  const DiagnoseDialoge({super.key});

  @override
  State<DiagnoseDialoge> createState() => _DiagnoseDialogeState();
}

class _DiagnoseDialogeState extends State<DiagnoseDialoge> {
  List<String> medications = [
    "Medication 1 (Brand Name)",
    "Medication 2 (Brand Name)",
    "Medication 3 (Brand Name)",
    "Medication 4 (Brand Name)"
  ];
  List<String> referrals = [
    "speacialit1",
    "Speacialit2",
    "Speacialit3",
  ];
  List<String> disease = [
    "Ear infections (otitis media)",
    "Sinusitis",
    "Tonsillitis",
    "Rhinitis (allergic rhinitis, common cold)",
    "Laryngitis",
    "Swimmer's ear (otitis externa)",
    "Hearing loss",
    "Vertigo",
    "Sinus headaches",
    "Earaches",
    "Nosebleeds",
    "Sleep apnea",
    "Thyroid problems",
    "Facial pain",
    "Neck masses",
    "Dysphagia (difficulty swallowing)"
  ];
  List<String> test_Images = [
    "Otoscopy",
    "Rhinoscopy",
    "Laryngoscopy (Indirect, Direct)",
    "Nasopharyngoscopy",
    "Audiometry",
    "Allergy testing"
        "X-ray",
    "CT scan",
    "MRI scan",
    "Ultrasound"
  ];

  List<String?> selectedMedications = [];
  List<String?> selectededRferrals = [];
  List<String?> selectedDisease = [];
  List<String?> selectedTest_Images = [];

  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // surfaceTintColor: (Theme.of(context).brightness == Brightness.light)
      //     ? const Color(0xFFE8F3FF)
      //     : const Color(0xFF004C6E),
      backgroundColor: (Theme.of(context).brightness == Brightness.light)
          ? const Color(0xFFE8F3FF)
          : const Color(0xFF004C6E),
      content: SizedBox(
        height: 1000,
        width: 1500,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color:
                            (Theme.of(context).brightness == Brightness.light)
                                ? const Color(0xFF001C2B)
                                : const Color(0xFFE8F3FF),
                      ),
                      hintText: 'Medical examination',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  controller: _descriptionController,
                ),
                const Gap(20),
                MultiDropDownCustomized(
                  items: referrals,
                  hintText: "Referrals",
                  onSelectionChange: (seleteditems) {
                    setState(() {
                      selectededRferrals = seleteditems;
                    });
                  },
                ),
                const Gap(20),
                MultiDropDownCustomized(
                  items: disease,
                  hintText: "Disease",
                  onSelectionChange: (seleteditems) {
                    setState(() {
                      selectedDisease = seleteditems;
                    });
                  },
                ),
                const Gap(20),
                MultiDropDownCustomized(
                  items: medications,
                  hintText: "Medications",
                  onSelectionChange: (seleteditems) {
                    setState(() {
                      selectedMedications = seleteditems;
                    });
                  },
                ),
                const Gap(20),
                MultiDropDownCustomized(
                  items: test_Images,
                  hintText: "Tests/Images",
                  onSelectionChange: (seleteditems) {
                    setState(() {
                      selectedTest_Images = seleteditems;
                    });
                  },
                ),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Textbuttoncontainer(
                      text: "cancel",
                      onPressed: () => Navigator.pop(context),
                    ),
                    Textbuttoncontainer(
                      text: "Confirm",
                      onPressed: () => {
                        print(selectedMedications),
                        print(selectededRferrals),
                        print(selectedDisease),
                        print(selectedTest_Images),
                        print(_descriptionController),
                        Navigator.pop(context)
                      },
                    ),
                    // ,Textbuttoncontainer(text: "Confirm")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultiDropDownCustomized extends StatefulWidget {
  const MultiDropDownCustomized(
      {super.key,
      required this.items,
      required this.hintText,
      required this.onSelectionChange});
  final List<String> items;
  final String hintText;
  final Function(List<String>) onSelectionChange;
  @override
  State<MultiDropDownCustomized> createState() => _DropDownState();
}

class _DropDownState extends State<MultiDropDownCustomized> {
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      backgroundColor: (Theme.of(context).brightness == Brightness.light)
          ? const Color(0xFFE8F3FF)
          : const Color(0xFF004C6E),
      checkColor: const Color(0xFFE8F3FF),
      title: Text(widget.hintText,
          style: TextStyle(
            color: (Theme.of(context).brightness == Brightness.light)
                ? const Color(0xFF001C2B)
                : const Color(0xFFE8F3FF),
          )),
      buttonText: Text(widget.hintText,
          style: const TextStyle(
              // decorationColor: Color(0xFFE8F3FF),
              )),
      // unselectedColor: const Color(0xFFE8F3FF),
      buttonIcon: const Icon(Icons.add),
      items: widget.items.map((item) => MultiSelectItem(item, item)).toList(),
      selectedColor: const Color.fromARGB(255, 12, 124, 176),
      itemsTextStyle: TextStyle(
        color: (Theme.of(context).brightness == Brightness.light)
            ? const Color(0xFF001C2B)
            : const Color(0xFFE8F3FF),
      ),
      onConfirm: (values) {
        setState(() {
          selected = values;
        });
        widget.onSelectionChange(selected);
      },
    );
  }
}
