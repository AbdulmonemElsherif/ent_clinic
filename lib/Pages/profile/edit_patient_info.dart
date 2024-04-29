import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';



class EditPatientInfoPage extends StatefulWidget {
  @override
  _EditPatientInfoPageState createState() => _EditPatientInfoPageState();
}

class _EditPatientInfoPageState extends State<EditPatientInfoPage> {
  final _formKey = GlobalKey<FormState>();


  Future<DocumentSnapshot> getUserProfile() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .get();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Patient Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),child: FutureBuilder(
          future: getUserProfile(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            String dateString = snapshot.data!['dob']; // replace 'dob' with the actual field name in Firestore
            DateTime dob = DateTime.parse(dateString);

    return SingleChildScrollView( child:Form(
    key: _formKey,
    child: SingleChildScrollView(
    child: Column(
    children: <Widget>[
    DropdownButtonFormField<String>(
    decoration: const InputDecoration(labelText:'Gender',enabledBorder: OutlineInputBorder(
    borderRadius:
    BorderRadius.all(Radius.circular(20.0)),
    borderSide:
    BorderSide(color: Colors.grey, width: 0.0),
    ),
    border: OutlineInputBorder()),
    items: <String>['Male', 'Female'].map((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    );
    }).toList(),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please select an option';
    }
    return null;
    },
    onChanged: (value) {
    // Handle change
    },
    ),
    const SizedBox(
    height: 20,
    ),
    TextFormField(
      initialValue: snapshot.data!['name'],
    decoration: const InputDecoration(labelText: 'Name', enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide:
    BorderSide(color: Colors.grey, width: 0.0),
    ),
    border: OutlineInputBorder()),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter some text';
    }
    return null;
    },
    ),
    const SizedBox(
    height: 20,
    ),
    TextFormField(
      initialValue: snapshot.data!['patientID'],
    decoration: const InputDecoration(labelText: 'Patient ID', enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide:
    BorderSide(color: Colors.grey, width: 0.0),
    ),
    border: OutlineInputBorder()),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter some text';
    }
    return null;
    },
    ),
    const SizedBox(
    height: 20,
    ),
      DateTimeField(
        initialValue: dob,
    format: DateFormat("yyyy-MM-dd"),
        decoration: const InputDecoration(
          labelText: 'Date of Birth',
          border: OutlineInputBorder(),
        ),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          return date;
        },
        validator: (value) {
          if (value == null || value.toString().isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    const SizedBox(
    height: 20,
    ),
    TextFormField(
      initialValue: snapshot.data!['email'],
    decoration: const InputDecoration(labelText: 'Email', enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide:
    BorderSide(color: Colors.grey, width: 0.0),
    ),
    border: OutlineInputBorder()),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter some text';
    }
    return null;
    },
    ),
    const SizedBox(
    height: 20,
    ),
    TextFormField(
      initialValue: snapshot.data!['phone'],
    decoration: const InputDecoration(labelText: 'Phone', enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide:
    BorderSide(color: Colors.grey, width: 0.0),
    ),
    border: OutlineInputBorder()),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter some text';
    }
    return null;
    },
    ),
    const SizedBox(
    height: 20,
    ),
    // Add more fields as needed
    ElevatedButton(
    onPressed: () {
    if (_formKey.currentState!.validate()) {
    // Save the changes and navigate back to the profile page
    Navigator.pop(context);
    }
    },
    child: Text('Save'),
    ),
    ],
    ),
    )
    ),
    );
    } else if (snapshot.connectionState == ConnectionState.none) {
    return const Text("No data");
    }
    return const CircularProgressIndicator();
    },
    )));
  }
}
