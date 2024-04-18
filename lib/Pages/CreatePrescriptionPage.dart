import 'package:flutter/material.dart';

class CreatePrescriptionPage extends StatefulWidget {
  const CreatePrescriptionPage({Key? key}) : super(key: key);

  @override
  _CreatePrescriptionPageState createState() => _CreatePrescriptionPageState();
}

class _CreatePrescriptionPageState extends State<CreatePrescriptionPage> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Prescription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _medicineController,
              decoration: const InputDecoration(
                labelText: 'Medicine',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dosageController,
              decoration: const InputDecoration(
                labelText: 'Dosage',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _savePrescription();
              },
              child: const Text('Save Prescription'),
            ),
          ],
        ),
      ),
    );
  }

  void _savePrescription() {
    final String medicine = _medicineController.text.trim();
    final String dosage = _dosageController.text.trim();

    // Here you can implement logic to save the prescription data
    // For example, you can add the prescription to a list or send it to a database
    // This is just a placeholder function for demonstration purposes

    if (medicine.isNotEmpty && dosage.isNotEmpty) {
      // Perform actions to save the prescription
      Navigator.pop(context, 'Prescription saved: $medicine - $dosage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter medicine and dosage.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
