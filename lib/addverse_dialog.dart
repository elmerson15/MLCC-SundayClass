import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class AddverseDialog extends StatefulWidget {
  const AddverseDialog({super.key});

  @override
  State<AddverseDialog> createState() => _AddverseDialogState();
}

class _AddverseDialogState extends State<AddverseDialog> {


final _date = TextEditingController();
final _title = TextEditingController();
final _titleeng = TextEditingController();
final _verse = TextEditingController();
final _verse_english = TextEditingController();

final databaseRef = FirebaseDatabase.instance.ref("memoryverse");
DateTime? preferreddate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Verse'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _date,
            onTap: () async {
              preferreddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(2024),
                  lastDate: DateTime(2101)
              );

              if(preferreddate != null ){
                String formattedStartDate = DateFormat('dd MMM yyyy').format(preferreddate!);
                String day = DateFormat('EEEE').format(preferreddate!);
                setState(() {
                  _date.text = formattedStartDate;
                });
              }
            },
            decoration: InputDecoration(labelText: 'Date'),
          ),
          TextField(
            controller: _title,
            decoration: InputDecoration(labelText: 'Tam Title'),
          ),
          TextField(
            controller: _titleeng,
            decoration: InputDecoration(labelText: 'Eng Title'),
          ),
          TextField(
            controller: _verse,
            decoration: InputDecoration(labelText: 'Tam Verse'),
          ),
          TextField(
            controller: _verse_english,
            decoration: InputDecoration(labelText: 'Eng Verse'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {


            String uploadId = await databaseRef.child("memoryverse").push().key.toString();
            await databaseRef.child(uploadId).set({
              'date':'${_date.text.toString()}',
              'title':'${_title.text.toString()}',
              'titleeng':'${_titleeng.text.toString()}',
              'verse':'${_verse.text.toString()}',
              'verseenglish':'${_verse_english.text.toString()}',
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
