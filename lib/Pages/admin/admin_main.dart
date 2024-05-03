import 'package:ent_clinic/Pages/admin/admin_home_page.dart';
import 'package:ent_clinic/Pages/admin/admin_appointments_page.dart';
import 'package:ent_clinic/Pages/admin/admin_statistics_page.dart';
import 'package:ent_clinic/Pages/settings/settings_page.dart';
import 'package:ent_clinic/core/routes/routes.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 0; // Keep track of the selected tab index

  // Pages to navigate to
  final _widgetOptions = [
    AdminHomePage(),
    AdminAppointmentsPage(),
    AdminStatisticsPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
