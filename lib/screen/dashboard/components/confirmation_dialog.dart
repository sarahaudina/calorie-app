import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
    BuildContext context,
    String title,
    String subtitle,
    Function execute) async {
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
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('YES'),
            onPressed: () {
              execute.call();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showDailyLimitReachedReminder(BuildContext context, Function execute) {
  return showConfirmationDialog(context, "Reminder", "Do you want to delete this item?",execute);
}