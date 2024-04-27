import 'package:ent_clinic/Pages/auth/signin.dart';
import 'package:ent_clinic/Pages/home/patient/home/patient_home.dart';
import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/Patient/patient_dashboard.dart';

class AppRoutes {
  // Signin page route
  static const String signin = '/signin';

  // Home page route
  static const String patient = '/patient';

  // Home page route
  static const String home = '/home';
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.signin: (context) => const SignInPage(),
  AppRoutes.home: (context) => const PatientHomePage(),
  AppRoutes.patient: (context) => const PatientDashboardPage(),
};
