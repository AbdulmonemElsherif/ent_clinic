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

class Textbuttoncontainer extends StatelessWidget {
  const Textbuttoncontainer({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String? text;
  // final Function(List<String>) onSelectionChange;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 100,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.blue,
        ),
        child: Center(
          child: RegularText(
            text: text!,
            fontsize: 15,
          ),
        ),
      ),
    );
  }
}
