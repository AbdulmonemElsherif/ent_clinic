import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  RegularText({super.key, required this.text, this.fontsize = 20});
  final String text;
  double fontsize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: fontsize),
    );
  }
}
