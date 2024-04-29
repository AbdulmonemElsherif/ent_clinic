import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
      child: Image.asset(
        'assets/images/ent_clinic.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
