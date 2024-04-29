import 'package:ent_clinic/Pages/auth/signup.dart';
import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpPage()),
        );
      },
      child: Text(
        'New user? Sign Up',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
