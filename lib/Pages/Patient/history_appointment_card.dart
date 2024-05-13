import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryAppointmentCard extends StatelessWidget {
  final QueryDocumentSnapshot historyData;

  const HistoryAppointmentCard({Key? key, required this.historyData}) : super(key: key);

  Future<DocumentSnapshot> fetchDiagnosisData() {
    return FirebaseFirestore.instance.collection('diagnoses').doc(historyData.id).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: fetchDiagnosisData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var diagnosisData = snapshot.data!;
          return Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/doctor_2.png',
                        width: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded( 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${historyData['doctor']}",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text("Specialist", style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(height: 18),
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8.0,
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Icon(
                                  Ionicons.calendar_outline,
                                  size: 18,
                                  color: Colors.black87,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6, right: 14),
                                  child: Text(
                                    DateFormat('dd/MM/yyyy').format(historyData['date'].toDate()),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Ionicons.time_outline,
                                    size: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    historyData['time'],
                                    style: TextStyle(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Text(
                            "Diagnosis: ",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            historyData['diagnosed'] ? "Yes" : "No",
                            style: TextStyle(fontSize: 14),
                          ),
                          const Text(
                            "Complaint: ",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            historyData['complaint'],
                            style: TextStyle(fontSize: 14),
                          ),
                          const Text(
                            "Reason: ",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            historyData['reason'],
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Diagnosis Details: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Description: ${diagnosisData['description']}",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "Disease: ${diagnosisData['disease'].isNotEmpty ? diagnosisData['disease'][0] : 'No data found'}",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "Medications: ${diagnosisData['medications'].isNotEmpty ? diagnosisData['medications'][0] : 'No data found'}",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "Referrals: ${diagnosisData['referrals'].isNotEmpty ? diagnosisData['referrals'][0] : 'No data found'}",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "Test Images: ${diagnosisData['testImages'].isNotEmpty ? diagnosisData['testImages'][0] : 'No data found'}",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}