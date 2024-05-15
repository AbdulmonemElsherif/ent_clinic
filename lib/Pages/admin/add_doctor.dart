import 'package:ent_clinic/Pages/auth/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class AddDoctorPage extends StatefulWidget {
  const AddDoctorPage({super.key});

  @override
  _AddDoctorPageState createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final _formKey = GlobalKey<FormState>();
  String specialty = '';
  String dob = '';
  String email = '';
  String gender = '';
  String password = '';
  String name = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctor'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const Logo(),
            buildTextFormField(
              label: 'Name',
              icon: Icons.badge,
              saveFn: (value) => name = value ?? '',
              validatorFn: (value) => value == null || value.isEmpty
                  ? 'Please enter the name'
                  : null,
            ),
            buildTextFormField(
              label: 'Email',
              icon: Icons.email,
              saveFn: (value) => email = value ?? '',
              validatorFn: (value) => value == null || value.isEmpty
                  ? 'Please enter an email'
                  : null,
            ),
            buildTextFormField(
              label: 'Specialty',
              icon: Icons.local_hospital,
              saveFn: (value) => specialty = value ?? '',
              validatorFn: (value) => value == null || value.isEmpty
                  ? 'Please enter the specialty'
                  : null,
            ),
            buildTextFormField(
              label: 'Date of Birth (YYYY-MM-DD)',
              icon: Icons.calendar_today,
              saveFn: (value) => dob = value ?? '',
              validatorFn: (value) => value == null || value.isEmpty
                  ? 'Please enter the date of birth'
                  : null,
            ),
            buildTextFormField(
              label: 'Password',
              icon: Icons.password,
              saveFn: (value) => password = value ?? '',
              validatorFn: (value) => value == null || value.isEmpty
                  ? 'Please enter the password'
                  : null,
            ),
            buildTextFormField(
              label: 'Gender',
              icon: Icons.person,
              saveFn: (value) => gender = value ?? '',
              validatorFn: (value) => value == null || value.isEmpty
                  ? 'Please enter the gender'
                  : null,
            ),
            buildTextFormField(
              label: 'Phone',
              icon: Icons.phone,
              saveFn: (value) => phone = value ?? '',
              validatorFn: (value) => value == null || value.isEmpty
                  ? 'Please enter a phone number'
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    createDoctor(
                      email: email,
                      password: password,
                      specialty: specialty,
                      dob: dob,
                      gender: gender,
                      name: name,
                      phone: phone,
                    );
                  }
                },
                child: const Text('Add Doctor'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String label,
    required IconData icon,
    required String Function(String?) saveFn,
    required String? Function(String?) validatorFn,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true, // Filled background
          fillColor: Colors.black.withOpacity(0.05), // Light grey fill color
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // No border
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          prefixIcon: Icon(icon, color: Colors.grey),
          errorBorder: OutlineInputBorder(
            // Error state border
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            // Active state border
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validatorFn,
        onSaved: saveFn,
      ),
    );
  }
}
