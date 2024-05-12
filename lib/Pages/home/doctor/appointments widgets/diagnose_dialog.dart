import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/core/GeneralWidgets/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class DiagnoseDialoge extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String patientId;
  final String patientName;

  const DiagnoseDialoge({
    required this.doctorId,
    required this.doctorName,
    required this.patientId,
    required this.patientName,
    Key? key,
  }) : super(key: key);

  @override
  State<DiagnoseDialoge> createState() => _DiagnoseDialogeState();
}

class _DiagnoseDialogeState extends State<DiagnoseDialoge> {
  List<String> medications = [
    "Amoxicillin",
    "Augmentin",
    "Azithromycin",
    "Bactrim",
    "Biaxin",
    "Cefzil",
    "Cipro",
    "Cleocin",
    "Duricef",
    "Erythromycin",
    "Keflex",
    "Levaquin",
    "Omnicef",
    "Septra",
    "Suprax",
    "Tetracycline",
    "Vantin",
    "Zithromax",
    "Zmax",
    "Zosyn",
    "Zyvox"
  ];
  List<String> referrals = [
    "Audiologist",
    "Allergist",
    "Cardiologist",
    "Dentist",
    "Dermatologist",
    "Endocrinologist",
    "Gastroenterologist",
    "Hematologist",
    "Infectious Disease Specialist",
    "Internist",
    "Nephrologist",
    "Neurologist",
    "Obstetrician",
    "Oncologist",
    "Ophthalmologist",
    "Orthopedic Surgeon",
    "Otolaryngologist",
    "Pediatrician",
    "Physiatrist",
    "Plastic Surgeon",
    "Podiatrist",
    "Psychiatrist",
    "Pulmonologist",
    "Radiologist",
    "Rheumatologist",
    "Urologist",
    "Vascular Surgeon"
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
                      onPressed: () {
                        print(selectedMedications);
                        print(selectededRferrals);
                        print(selectedDisease);
                        print(selectedTest_Images);
                        print(_descriptionController.text);

                        FirebaseFirestore.instance.collection('diagnoses').add({
                          'doctorId': widget.doctorId,
                          'doctorName': widget.doctorName,
                          'patientId': widget.patientId,
                          'patientName': widget.patientName,
                          'description': _descriptionController.text,
                          'medications': selectedMedications,
                          'referrals': selectededRferrals,
                          'disease': selectedDisease,
                          'testImages': selectedTest_Images,
                        });

                        Navigator.pop(context);
                      },
                    ),
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