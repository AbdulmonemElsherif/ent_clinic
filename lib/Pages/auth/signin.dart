import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent_clinic/Pages/Patient/patient_dashboard.dart';
import 'package:ent_clinic/Pages/admin/admin_main.dart';
import 'package:ent_clinic/Pages/auth/widgets/email_field.dart';
import 'package:ent_clinic/Pages/auth/widgets/password_field.dart';
import 'package:ent_clinic/Pages/auth/widgets/signin_button.dart';
import 'package:ent_clinic/Pages/auth/widgets/signup_button.dart';
import 'package:ent_clinic/Pages/auth/widgets/welcome_text.dart';
import 'package:ent_clinic/Pages/home/doctor/doctor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_password.dart';
import 'signup.dart';
import 'widgets/logo.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Logo(),
              const WelcomeText(),
              EmailField(
                controller: _emailController,
              ),
              PasswordField(
                controller: _passwordController,
              ),
              SigninButton(
                onPressed: _signIn,
              ),
              const SignupButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future<DocumentSnapshot> getUserData() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .get();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        DocumentSnapshot snapshot = await getUserData();

        switch (snapshot['role']) {
          case 'doctor':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorPage(),
              ),
            );
            break;
          case 'patient':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PatientDashboardPage(),
              ),
            );
            break;
          case 'admin':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminMainPage(),
              ),
            );

          default:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PatientDashboardPage(),
              ),
            );
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
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
