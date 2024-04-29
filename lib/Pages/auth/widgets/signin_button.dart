import 'package:ent_clinic/Pages/auth/reset_password.dart';
import 'package:flutter/material.dart';

class SigninButton extends StatelessWidget {
  final void Function()? onPressed;
  const SigninButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
          ),
          child: const Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResetPassword()),
            );
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
