import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  String deleteKey = "";
  String keyValue = "";


  DeleteDialog(this.deleteKey,this.keyValue);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState(deleteKey,keyValue);
}

class _DeleteDialogState extends State<DeleteDialog> {

  String deleteKey = "";

  String keyValue = "";

  _DeleteDialogState(this.deleteKey,this.keyValue);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure to delete This Data ?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await FirebaseDatabase.instance.ref("userdata").child(keyValue).child("list").child(deleteKey).remove();
            Navigator.of(context).pop();
          },
          child: Text('Delete'),
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
