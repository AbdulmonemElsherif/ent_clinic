import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateAppointmentPage extends StatefulWidget {
  final String patient;
  const CreateAppointmentPage({super.key, required this.patient});

  @override
  _CreateAppointmentPageState createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  String? selectedDoctor;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? selectedReason;
  String? selectedIcon;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedComplaint;

  Map<String, String> doctors = {};
  List<String> reasons = [
    'General Checkup',
    'Follow-up Appointment',
    'Other Reason'
  ];
  List<String> earComplaints = [
    'Earache',
    'Hearing Loss',
    'Ear Infection',
    'Tinnitus',
    'Vertigo',
    'Earwax Blockage',
    'Ear Discharge',
    'Cholesteatoma',
    'Meniere\'s Disease',
    'Acoustic Neuroma',
    'Ear Drum Perforation',
    'Foreign Body in Ear'
  ];
  List<String> noseComplaints = [
    'Headache and facial pain',
    'Nose Bleed',
    'Loss of Smell',
    'Nasal Congestion',
    'Runny Nose',
    'Sneezing',
    'Noisy breathing sound',
    'Nasal Obstruction',
    'Nasal Septum Deviation',
    'Nasal Turbinate Hypertrophy',
    'Nasal Vestibulitis'
  ];

  List<String> throatComplaints = [
    'Sore Throat',
    'Swallowing Difficulty',
    'Throat Pain',
    'Bloody cough',
    'Throat Inflammation',
    'Neck Swelling',
    'Throat Dryness',
    'Throat Itching/Burning',
    'Throat Lump',
    'Snoring and difficult breathing during sleeping',
    'Throat Discomfort',
  ];

  List<String> currentComplaints = [];

  @override
  void initState() {
    super.initState();
    fetchDoctors();
    selectedComplaint = null;
  }

  Future<void> fetchDoctors() async {
  final QuerySnapshot snapshot = await _firestore
      .collection('users')
      .where('role', isEqualTo: 'doctor')
      .get();
  final Map<String, String> fetchedDoctors = {};
  for (var doc in snapshot.docs) {
    fetchedDoctors[doc['name']] = doc.id; // Store the doctor's name and ID
  }
  setState(() {
    doctors = fetchedDoctors;
  });
}

  void setComplaints(List<String> complaints) {
    setState(() {
      currentComplaints = List.from(complaints); // Update currentComplaints
    });
  }

  void selectIcon(String icon) {
    setState(() {
      selectedIcon = icon;
      selectedComplaint = null; // Reset selectedComplaint when the icon changes
    });
  }

  Future<void> createAppointment() async {
    try {
      await _firestore.collection('appointments').add({
        'doctor': selectedDoctor,
        'doctorID' : doctors[selectedDoctor],
        'date': selectedDate,
        'time': selectedTime.format(context),
        'reason': selectedReason,
        'patient': widget.patient,
        'complaint': selectedComplaint,
        'approvalStatus': 'pending',
        'dianosed': false,
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Appointment created successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to create appointment: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Choose Doctor:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
                  value: selectedDoctor,
                  onChanged: (newValue) {
                    setState(() {
                      selectedDoctor = newValue;
                    });
                  },
                  items: doctors.keys.map((doctor) {
                    return DropdownMenuItem<String>(
                      value: doctor,
                      child: Text(doctor),
                    );
                  }).toList(),
                ),
            const SizedBox(height: 20),
            const Text(
              'Select Date and Time:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                      'Choose Date: ${selectedDate.toString().split(' ')[0]}'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (pickedTime != null && pickedTime != selectedTime) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                  },
                  child: Text('Choose Time: ${selectedTime.format(context)}'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Reason for Appointment:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedReason,
              onChanged: (newValue) {
                setState(() {
                  selectedReason = newValue;
                });
              },
              items: reasons.map((reason) {
                return DropdownMenuItem<String>(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Select Complaint:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedIcon == 'ear'
                          ? const Color.fromARGB(255, 0, 26, 255)
                              .withOpacity(0.5)
                          : const Color.fromARGB(0, 0, 0, 0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/ear.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setComplaints(earComplaints);
                    selectIcon('ear');
                    selectedIcon = 'ear';
                  },
                ),
                IconButton(
                  icon: Container(
                    width: 60, // Adjust the width to your desired size
                    height: 60, // Adjust the height to your desired size
                    decoration: BoxDecoration(
                      color: selectedIcon == 'nose'
                          ? const Color.fromARGB(255, 0, 26, 255)
                              .withOpacity(0.5)
                          : const Color.fromARGB(0, 0, 0, 0),
                      borderRadius: BorderRadius.circular(
                          30), // Optional: Add border radius for rounded corners
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/nose.png',
                        width: 40, // Adjust the image size as needed
                        height: 40,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setComplaints(noseComplaints);
                    selectIcon('nose');
                    selectedIcon = 'nose';
                  },
                ),
                IconButton(
                  icon: Container(
                    width: 60, // Adjust the width to your desired size
                    height: 60, // Adjust the height to your desired size
                    decoration: BoxDecoration(
                      color: selectedIcon == 'throat'
                          ? const Color.fromARGB(255, 0, 26, 255)
                              .withOpacity(0.5)
                          : const Color.fromARGB(0, 0, 0, 0),
                      borderRadius: BorderRadius.circular(
                          30), // Optional: Add border radius for rounded corners
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/throat.png',
                        width: 40, // Adjust the image size as needed
                        height: 40,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setComplaints(throatComplaints);
                    selectIcon('throat');
                    selectedIcon = 'throat';
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (currentComplaints.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  DropdownButton<String>(
                    value: selectedComplaint,
                    onChanged: (newValue) {
                      setState(() {
                        if (selectedIcon == 'ear' &&
                            earComplaints.contains(newValue)) {
                          selectedComplaint = newValue!;
                        } else if (selectedIcon == 'nose' &&
                            noseComplaints.contains(newValue)) {
                          selectedComplaint = newValue!;
                        } else if (selectedIcon == 'throat' &&
                            throatComplaints.contains(newValue)) {
                          selectedComplaint = newValue!;
                        }
                      });
                    },
                    items: selectedIcon == 'ear'
                        ? earComplaints.map((complaint) {
                            return DropdownMenuItem<String>(
                              value: complaint,
                              child: Text(complaint),
                            );
                          }).toList()
                        : selectedIcon == 'nose'
                            ? noseComplaints.map((complaint) {
                                return DropdownMenuItem<String>(
                                  value: complaint,
                                  child: Text(complaint),
                                );
                              }).toList()
                            : throatComplaints.map((complaint) {
                                return DropdownMenuItem<String>(
                                  value: complaint,
                                  child: Text(complaint),
                                );
                              }).toList(),
                    isExpanded: true, // Expand the dropdown menu horizontally
                  ),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedDoctor != null && selectedReason != null) {
                  createAppointment();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Please select a doctor and reason for the appointment.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Create Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
