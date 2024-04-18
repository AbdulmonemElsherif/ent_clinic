import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/SignIn.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.notoSansTextTheme(),
      ),
      home: SignInPage(), // Navigate to SignInPage by default
      debugShowCheckedModeBanner: false,
    );
  }
}