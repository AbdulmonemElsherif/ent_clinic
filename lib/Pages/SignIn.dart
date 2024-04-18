import 'package:flutter/material.dart';
import 'HomePage/homepage.dart'; // Import the HomePage widget

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Simulate successful sign-in for demonstration purposes
                // Replace this with your actual sign-in logic
                _signIn(context);
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                _skipSignIn(context);
              },
              child: const Text('Skip Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle sign-in
  void _signIn(BuildContext context) {
    // Simulate successful sign-in for demonstration purposes
    // Replace this with your actual sign-in logic
    bool isAuthenticated = true; // Assume user is authenticated

    if (isAuthenticated) {
      // Navigate to the home page (HomePage)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Handle sign-in failure, show error message, etc.
    }
  }

  // Function to handle skipping sign-in
  void _skipSignIn(BuildContext context) {
    // Navigate to the home page (HomePage)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
