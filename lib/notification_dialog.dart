
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationDialog extends StatefulWidget {
  List<String> list = [];


  NotificationDialog(this.list);

  @override
  State<NotificationDialog> createState() => _NotificationDialogState(list);
}

class _NotificationDialogState extends State<NotificationDialog> {

  List<String> list = [];


  _NotificationDialogState(this.list);

  final _titleContent = TextEditingController();
  final _notificationContent = TextEditingController();


  DateTime? preferreddate;


  Future<http.Response?> sendNotificationToUser(List<String> tokenIdList, String contents, String heading) async {
    const String apiKey = 'MDM1MzQyZjEtMzdhZC00OWY0LTg3NTQtNTE5ZDhmYTM3YTFh';  // Your OneSignal REST API key
    print("dbb");

    try {
      final response = await http.post(
        Uri.parse('https://onesignal.com/api/v1/notifications'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Basic $apiKey',  // Use your OneSignal REST API key here
        },
        body: jsonEncode(<String, dynamic>{
          "app_id": "875ea179-ee15-4e10-a399-cc94d4781856",  // Your OneSignal App ID
          "include_player_ids": tokenIdList,  // List of OneSignal player IDs
          "android_accent_color": "FF9976D2",  // Accent color of the notification
          "small_icon": "ic_launcher",  // Notification icon
          "headings": {"en": heading.isNotEmpty ? heading : "New Notification"},  // Heading in English
          "contents": {"en": contents.isNotEmpty ? contents : "This is a default message"},  // Content in English
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      return response;
    } catch (e) {
      print("Error sending notification: $e");
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Notification'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleContent,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _notificationContent,
            decoration: InputDecoration(labelText: 'Notify Content'),
          ),

        ],
      ),


      actions: [
        TextButton(
          onPressed: () async {

            // await sendNotificationToUser(["13ea2061-917b-4da3-9ded-8fbf40365260"],"","");
            for(String key in list){
              await sendNotificationToUser([key.toString()], _notificationContent.text.toString(), _titleContent.text.toString());
            }
            Navigator.of(context).pop();
          },
          child: Text('Send'),
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


