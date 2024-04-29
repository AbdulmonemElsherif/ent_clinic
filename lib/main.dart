import 'package:ent_clinic/ent_clinical_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    return;
  }
  runApp(const EntClinicalApp());
}