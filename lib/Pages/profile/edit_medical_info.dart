import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class EditMedicalInfoPage extends StatefulWidget {
  final String documentId;

  EditMedicalInfoPage({required this.documentId});

  @override
  _EditMedicalInfoPageState createState() => _EditMedicalInfoPageState();
}

class _EditMedicalInfoPageState extends State<EditMedicalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  String smokerValue = '';
  String specialMedicalHabitsValue = '';
  List<String> chronicDiseasesValue = [];
  List<String> drugsValue = [];
  List<String> allergiesValue = [];
  String bloodTypeValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Medical Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Are you a smoker',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Yes', 'No'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      smokerValue = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Special Medical Habit',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Yoga', 'Meditation', 'Gluten-free diet', 'Vegan diet', 'Regular exercise'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      specialMedicalHabitsValue = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chronic Diseases',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    MultiSelectDialogField(
                      items: ['Diabetes', 'Hypertension', 'Arthritis', 'Asthma', 'Heart Disease', 'Cancer', 'Chronic Kidney Disease', 'Stroke', 'Chronic respiratory diseases', 'Hepatitis'].map((disease) => MultiSelectItem(disease, disease)).toList(),
                      selectedColor: Colors.blue,
                      onConfirm: (values) {
                        setState(() {
                          chronicDiseasesValue = values;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drugs',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    MultiSelectDialogField(
                      items: ['Aspirin', 'Metformin', 'Lisinopril', 'Ibuprofen', 'Paracetamol', 'Amoxicillin', 'Ciprofloxacin', 'Doxycycline', 'Furosemide', 'Gabapentin', 'Hydrochlorothiazide', 'Prednisone', 'Trazodone', 'Zolpidem', 'Sertraline', 'Simvastatin', 'Omeprazole', 'Losartan', 'Alprazolam', 'Atorvastatin', 'Tramadol', 'Hydrocodone/Acetaminophen', 'Amlodipine', 'Azithromycin', 'Fluoxetine', 'Lorazepam', 'Clonazepam', 'Lisinopril', 'Citalopram', 'Metoprolol', 'Pantoprazole', 'Meloxicam', 'Rosuvastatin', 'Clopidogrel', 'Escitalopram', 'Pravastatin', 'Bupropion', 'Carvedilol', 'Metformin', 'Atenolol', 'Gabapentin', 'Sertraline', 'Simvastatin', 'Levothyroxine', 'Losartan', 'Montelukast', 'Omeprazole', 'Pantoprazole', 'Rosuvastatin', 'Tramadol', 'Trazodone', 'Zolpidem'].map((drug) => MultiSelectItem(drug, drug)).toList(),
                      selectedColor: Colors.blue,
                      onConfirm: (values) {
                        setState(() {
                          drugsValue = values;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allergies',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      MultiSelectDialogField(
                        items: ['Peanuts', 'Tree nuts', 'Milk', 'Egg', 'Wheat', 'Soy', 'Fish', 'Shellfish', 'Sesame', 'Mustard'].map((allergy) => MultiSelectItem(allergy, allergy)).toList(),
                        selectedColor: Colors.blue,
                        onConfirm: (values) {
                          setState(() {
                            allergiesValue = values;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),const SizedBox(
                                    height: 20,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Blood Type',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      bloodTypeValue = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Reference to the document
                      DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(widget.documentId);
                
                      // Check if the document exists
                      docRef.get().then((doc) {
                        if (doc.exists) {
                          // If the document exists, update it
                          docRef.update({
                            'smoker': smokerValue,
                            'specialMedicalHabits': specialMedicalHabitsValue,
                            'chronicDiseases': chronicDiseasesValue,
                            'drugs': drugsValue,
                            'bloodType': bloodTypeValue,
                            'allergies': allergiesValue,
                          });
                        } else {
                          // If the document does not exist, create it
                          docRef.set({
                            'smoker': smokerValue,
                            'specialMedicalHospital': specialMedicalHabitsValue,
                            'chronicDiseases': chronicDiseasesValue,
                            'drugs': drugsValue,
                            'bloodType': bloodTypeValue,
                            'allergies': allergiesValue,
                          });
                        }
                      });
                
                      // Navigate back to the profile page
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}