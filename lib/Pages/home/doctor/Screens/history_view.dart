import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryItemScreen extends StatelessWidget {
  final String historyItemId;

  HistoryItemScreen({required this.historyItemId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('history').doc(historyItemId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final doc = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('History Item Details'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Diagnosed: ${doc['diagnosed']}'),
                  // Add more fields here as needed
                ],
              ),
            ),
          );
        }
      },
    );
  }
}