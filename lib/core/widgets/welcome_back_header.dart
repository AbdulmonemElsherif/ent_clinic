import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WelcomeBackHeader extends StatefulWidget {
  const WelcomeBackHeader({
    super.key,
  });

  @override
  State<WelcomeBackHeader> createState() => _WelcomeBackHeaderState();
}

class _WelcomeBackHeaderState extends State<WelcomeBackHeader> {
  Future<String> getAdminName() async {
    // Replace 'admins' and 'adminId' with the actual collection name and document ID
    DocumentSnapshot adminDoc = await FirebaseFirestore.instance
        .collection('admins')
        .doc('adminId')
        .get();
    return adminDoc['name']; // Replace 'name' with the actual field name
  }


// Widget build(BuildContext context) {
  Widget _showProfile() {
    // Logic to show user profile
    return Text(
      "getAdminName()",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 24,
      ),
    );
  }

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
              _showProfile(),
            ],
          ),
          CircleAvatar(
            backgroundImage: NetworkImage("widget.imagePath"),
            maxRadius: 24,
          ),
        ],
      ),
    );
  }
}
