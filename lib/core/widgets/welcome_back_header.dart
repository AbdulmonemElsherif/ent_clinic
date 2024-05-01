import 'package:flutter/material.dart';

class WelcomeBackHeader extends StatelessWidget {
  final String userName;
  final String imagePath;

  const WelcomeBackHeader({
    super.key,
    required this.userName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'WELCOME BACK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(imagePath),
            maxRadius: 24,
          ),
        ],
      ),
    );
  }
}
