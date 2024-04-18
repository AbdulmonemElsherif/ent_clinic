import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/SignIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(), // Navigate to SignInPage by default
      debugShowCheckedModeBanner: false,
    );
  }
}