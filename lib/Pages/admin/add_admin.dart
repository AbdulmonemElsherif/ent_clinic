import 'package:ent_clinic/Pages/auth/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class AddAdminPage extends StatefulWidget {
  const AddAdminPage({super.key});

  @override
  _AddAdminPageState createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String gender = '';
  String password = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Admin'),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    createAdmin(
                      email: email,
                      password: password,
                      gender: gender,
                      name: name,
                    );
                  }
                },
                child: const Text('Add Admin'),
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
