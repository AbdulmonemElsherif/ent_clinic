import 'package:ent_clinic/core/routes/routes.dart';
import 'package:ent_clinic/core/theme/themes.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import 'admin_appointment_card.dart';


class ListOfAppointments extends StatefulWidget {
  final List<Map<String, dynamic>> appointments;
  const ListOfAppointments({super.key, required this.appointments});

  @override
  State<ListOfAppointments> createState() => _ListOfAppointmentsState();
}

class _ListOfAppointmentsState extends State<ListOfAppointments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.white,
        // shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pending Appointments',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          ExpansionTileCard(
            borderRadius: BorderRadius.circular(24.0),
            baseColor: Colors.white,
            title: Text(
              'Appointments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(
              'View latest appointments',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            leading: Icon(
              Icons.calendar_today,
              color: Theme.of(context).primaryColor,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 300,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: widget.appointments.length,
                    itemBuilder: (context, index) {
                      var appointment = widget.appointments[index];
                      return AdminAppointmentCard(
                        appointment: appointment,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
