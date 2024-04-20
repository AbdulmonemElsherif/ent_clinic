import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ENT Clinic',
      initialRoute: '/signin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(), // Navigate to SignInPage by default
      debugShowCheckedModeBanner: false,
    );
  }
}