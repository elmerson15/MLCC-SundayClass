import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNameDialog extends StatefulWidget {
  @override
  _AddNameDialogState createState() => _AddNameDialogState();
}

class _AddNameDialogState extends State<AddNameDialog> {
  final _nameController = TextEditingController();
  final _sectionController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _selectedClass = 'Nursery';

  final databaseRef = FirebaseDatabase.instance.ref("userdata");
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // To track validation errors
  String? _nameError;
  String? _sectionError;
  String? _phoneError;

  // Validation function
  bool _validateInput() {
    setState(() {
      _nameError = _nameController.text.isEmpty ? 'Name is required' : null;
      _sectionError = _sectionController.text.isEmpty ? 'Section is required' : null;
      _phoneError = _phoneNumberController.text.isEmpty ? 'Phone is required' : null;
    });

    return _nameError == null && _sectionError == null && _phoneError == null;
  }

  String getDateFun(){
    DateTime now = DateTime.now();

    // Format the date to display only the date portion (e.g., yyyy-MM-dd)
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Attendance'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: _nameError, // Show error message if validation fails
            ),
          ),
          TextField(
            controller: _sectionController,
            decoration: InputDecoration(
              labelText: 'Section',
              errorText: _sectionError, // Show error message if validation fails
            ),
          ),
          TextField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone',
              errorText: _phoneError, // Show error message if validation fails
            ),
          ),
          DropdownButton<String>(
            value: _selectedClass,
            onChanged: (String? newValue) {
              setState(() {
                _selectedClass = newValue!;
              });
            },
            items: ['Nursery', 'Beginner', 'Primary', 'Junior', 'Inter', 'Senior']
                .map((className) => DropdownMenuItem(
              value: className,
              child: Text(className),
            ))
                .toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_validateInput()) {
              String uploadId = await databaseRef.child("userdata").push().key.toString();
              await databaseRef.child(uploadId).set({
                'name': _nameController.text,
                'class': _selectedClass,
                'section': _sectionController.text,
                'phone': _phoneNumberController.text,
                'date': DateTime.now().toString(),
              });

              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
