import 'package:flutter/material.dart';

import 'addverse_dialog.dart';


class PasswordDialog extends StatefulWidget {
  const PasswordDialog({super.key});

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {

  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Verse'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _password,
            decoration: InputDecoration(labelText: 'Password'),
          ),

        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {


            // String uploadId = await databaseRef.child("userdata").push().key.toString();
            // await databaseRef.child(uploadId).set({
            //   'name':'${_nameController.text.toString()}',
            //   'section':'${_sectionController.text}',
            //   'phone':'${_phoneNumberControler.text}',
            //   'date':'${DateTime.now()}',
            // });

            if(_password.text == "mlccyEL"){
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => AddverseDialog(),
              );

            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("password incorrect")));
            }
          },
          child: Text('Enter'),
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
