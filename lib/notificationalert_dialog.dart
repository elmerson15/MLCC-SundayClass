import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mllccsundayclass/colors.dart';

class NotificationalertDialog extends StatefulWidget {
  const NotificationalertDialog({super.key});

  @override
  State<NotificationalertDialog> createState() => _NotificationalertDialogState();
}

class _NotificationalertDialogState extends State<NotificationalertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Welcome to Sunday Class !',
        style: TextStyle(
          color: Colors.green,
        ),
      ),
      content: Text("Please Restart the App to Continue",
      style: TextStyle(
        color: Colors.black,
      ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text('ok'),
        ),
      ],
    );
  }
}
