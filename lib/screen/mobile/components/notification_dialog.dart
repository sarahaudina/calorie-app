import 'package:flutter/material.dart';

Future<void> showReminderDialog(
    BuildContext context,
    String title,
    String subtitle) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(subtitle)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showDailyLimitReachedReminder(BuildContext context) {
  return showReminderDialog(context, "Reminder", "You have reached your daily caloty limit.");
}

Future<void> showMonthlyLimitReachedReminder(BuildContext context) {
  return showReminderDialog(context, "Reminder", "You have reached your monthly budget limit.");
}