import 'package:ent_clinic/Pages/admin/admin_main.dart';
import 'package:ent_clinic/Pages/admin/admin_appointments_page.dart';
import 'package:ent_clinic/Pages/admin/admin_home_page.dart';
import 'package:ent_clinic/Pages/admin/admin_statistics_page.dart';
import 'package:ent_clinic/Pages/auth/signin.dart';
import 'package:ent_clinic/Pages/home/doctor/Screens/doctor_homescreen.dart';
import 'package:ent_clinic/Pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:ent_clinic/Pages/Patient/patient_dashboard.dart';
import 'package:ent_clinic/Pages/home/doctor/Screens/appointment_fullinformation_screen.dart';

import '../../Pages/admin/add_admin.dart';
import '../../Pages/admin/add_doctor.dart';

class AppRoutes {
  // Signin page route
  static const String signin = '/signin';

  // Admin pages routes
  static const String adminMain = '/adminMain';
  static const String adminHome = '/adminHome';
  static const String adminAppointments = '/adminAppointments';
  static const String adminStatistics = '/adminStatistics';
    static const String addDoctor = '/addDoctor';
  static const String addAdmin = '/addAdmin';
  static const String settings = '/settings';

  // Home page route
  static const String home = '/home';
  static const String doctor = '/doctor';
  static const String doctorPatientInfo = '/doctor/patientinfo';
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.signin: (context) => const SignInPage(),
  AppRoutes.home: (context) => const PatientDashboardPage(),

  ///!!!!!matemsa7sh el 2 lines doooll 2o3aaaaaaaa
  ///
  AppRoutes.doctorPatientInfo: (context) => const AppointmentFullInformationScreen(appointmentId: '', patientName: '', patientId: '',),
  AppRoutes.doctor: (context) => const DoctorHomeScreen(),

  ///
  ///
  // Admin pages
  AppRoutes.adminMain: (context) => const AdminMainPage(),
  AppRoutes.adminHome: (context) => const AdminHomePage(),
  AppRoutes.adminAppointments: (context) => AdminAppointmentsPage(),
  AppRoutes.adminStatistics: (context) => AdminStatisticsPage(),
  AppRoutes.settings: (context) => const SettingsPage(),
  AppRoutes.addAdmin:(context) => const AddAdminPage(),
  AppRoutes.addDoctor:(context) => const AddDoctorPage(),

};
