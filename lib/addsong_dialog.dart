import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class AddsongDialog extends StatefulWidget {
  const AddsongDialog({super.key});

  @override
  State<AddsongDialog> createState() => _AddsongDialogState();
}

class _AddsongDialogState extends State<AddsongDialog> {


  final _title = TextEditingController();
  final _lyrics = TextEditingController();
  final _ytlink = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref("songlyrics");
  DateTime? preferreddate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Song'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _title,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _lyrics,
            decoration: InputDecoration(labelText: 'lyrics'),
          ),
          TextField(
            controller: _ytlink,
            decoration: InputDecoration(labelText: 'ytlink'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {


            String uploadId = await databaseRef.child("songlyrics").push().key.toString();
            await databaseRef.child(uploadId).set({
              'title':'${_title.text.toString()}',
              'lyrics':'${_lyrics.text.toString()}',
              'ytlink':'${_ytlink.text.toString()}',
            });

            Navigator.of(context).pop();
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
