import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          title: 'ENT Clinic Management System',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      const HomePage({super.key});
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ENT Clinic Management System'),
          ),
          body: const Center(
            child: Text('Welcome to the ENT Clinic Management System'),
          ),
        );
      }
    }