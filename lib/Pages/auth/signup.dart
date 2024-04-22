import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../home/patient/home/patient_home.dart';
import 'signin.dart';

enum UserType { patient, doctor }
enum Gender { male, female }

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _specializationController = TextEditingController();
  UserType _userType = UserType.patient;
  Gender _gender = Gender.male;
  String _specialization = 'Audiology'; // Default value

  List<String> specializations = [
    'Audiology',
    'Otology',
    'Rhinology',
    'Laryngology',
    // Add more specializations as needed
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          _buildNameField(),
                          SizedBox(height: 5),
                          _buildEmailField(),
                          SizedBox(height: 5),
                          _buildPasswordField(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: _buildGenderField(),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          _buildDOBField(),
                          SizedBox(height: 5),
                          _buildPhoneField(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: _buildUserTypeRadioButtons(),
                          ),
                          if (_userType == UserType.doctor)
                            Expanded(
                              child: _buildSpecializationField(),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildSignUpButton(),
                  SizedBox(height: 5),
                  _buildSignInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildUserTypeRadioButtons() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Patient'),
          leading: Radio<UserType>(
            value: UserType.patient,
            groupValue: _userType,
            onChanged: (UserType? value) {
              setState(() {
                _userType = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Doctor'),
          leading: Radio<UserType>(
            value: UserType.doctor,
            groupValue: _userType,
            onChanged: (UserType? value) {
              setState(() {
                _userType = value!;
              });
            },
          ),
        ),
      ],
    );
  }

 Widget _buildSpecializationField() {
    return DropdownButtonFormField<String>(
      value: _specialization,
      decoration: const InputDecoration(
        labelText: 'Specialization',
        border: OutlineInputBorder(),
      ),
      items: specializations.map((String specialization) {
        return DropdownMenuItem<String>(
          value: specialization,
          child: Text(specialization),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _specialization = newValue!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your specialization';
        }
        return null;
      },
    );
  }

 Widget _buildDOBField() {
    return DateTimeField(
      controller: _dobController,
      format: DateFormat("yyyy-MM-dd"),
      decoration: const InputDecoration(
        labelText: 'Date of Birth',
        border: OutlineInputBorder(),
      ),
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        return date;
      },
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'Please enter your date of birth';
        }
        return null;
      },
    );
  }

  Widget _buildGenderField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Radio<Gender>(
          value: Gender.male,
          groupValue: _gender,
          onChanged: (Gender? value) {
            setState(() {
              _gender = value!;
            });
          },
        ),
        Text('Male'),
        Radio<Gender>(
          value: Gender.female,
          groupValue: _gender,
          onChanged: (Gender? value) {
            setState(() {
              _gender = value!;
            });
          },
        ),
        Text('Female'),
      ],
    );
  }
  

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _registerUser,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16.0),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
          child: Text(
            'Already have an account? Sign In',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

Future<String> generatePatientID() async {
  // Get a reference to the counter document
  DocumentReference counterDoc = FirebaseFirestore.instance.collection('counters').doc('patientID');
  // Run a transaction to increment the counter
  return FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(counterDoc);
    if (!snapshot.exists) {
      // If the document doesn't exist, create it and set the counter to 1
      transaction.set(counterDoc, {'counter': 1});
      return '1';
    } else {
      // If the document exists, increment the counter and return it
      int newCounter = snapshot.get('counter') + 1;
      transaction.update(counterDoc, {'counter': newCounter});
      return newCounter.toString();
    }
  });
}

Future<void> _registerUser() async {
  if (_formKey.currentState!.validate()) {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Generate a simpler, unique patient ID
      String patientID = await generatePatientID(); // Note the 'await' keyword here
      // Save additional info to Firestore
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': _nameController.text,
        'email': _emailController.text,
        'dob': _dobController.text,
        'gender': _gender == Gender.male ? 'male' : 'female', 
        'phone': _phoneController.text,
        'patientID': patientID, // Use the generated patient ID
        'userType': _userType == UserType.patient ? 'patient' : 'doctor',
        'specialization': _userType == UserType.doctor
            ? _specializationController.text
            : null,
      });
      // Navigate to the next page if the registration was successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PatientHomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = 'Something went wrong. Please try again later.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
}