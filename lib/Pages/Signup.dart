import 'package:ent_clinic/Pages/Homepage/homepage.dart';
import 'package:ent_clinic/Pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { patient, doctor }

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _specializationController = TextEditingController();
  UserType _userType = UserType.patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildNameField(),
              _buildEmailField(),
              _buildPasswordField(),
              _buildUserTypeRadioButtons(),
              if (_userType == UserType.doctor) _buildSpecializationField(),
              _buildSignUpButton(),
              _buildSignInButton(),
            ],
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
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _specializationController,
          decoration: const InputDecoration(
            labelText: 'Specialization',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your specialization';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _registerUser,
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
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

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Save additional info to Firestore
        FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'name': _nameController.text,
          'email': _emailController.text,
          'userType': _userType == UserType.patient ? 'patient' : 'doctor',
          'specialization': _userType == UserType.doctor ? _specializationController.text : null,
        });
        // Navigate to the next page if the registration was successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
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