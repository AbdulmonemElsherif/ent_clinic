import 'package:ent_clinic/core/routes/routes.dart';
import 'package:flutter/material.dart';


class EntClinicalApp extends StatelessWidget {
  const EntClinicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ENT Clinic',
      initialRoute: AppRoutes.signin,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}