import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAabc123...', // replace with your API key
      authDomain: 'your-project-id.firebaseapp.com', // replace with your auth domain
      projectId: 'your-project-id', // replace with your project ID
      storageBucket: 'your-project-id.appspot.com', // replace with your storage bucket
      messagingSenderId: '1234567890', // replace with your messaging sender ID
      appId: '1:1234567890:web:abc123def456', // replace with your app ID
    ),
  );
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
      home: SignInPage(), // Navigate to SignInPage by default
      debugShowCheckedModeBanner: false,
    );
  }
}