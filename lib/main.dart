import 'package:ent_clinic/Pages/Homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Error initializing Firebase: $e');
    return;
  }
  runApp(MyApp());
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
      routes: {
        '/signin': (context) => SignInPage(),
        '/home': (context) => HomePage(),
      },
      //
      home: SignInPage(), // Navigate to SignInPage by default
      debugShowCheckedModeBanner: false,
    );
  }
}