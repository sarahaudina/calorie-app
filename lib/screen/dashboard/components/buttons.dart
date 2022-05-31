import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final Function tap;
  final Color? color;

  const DefaultButton(this.title, this.tap, {this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        tap();
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ?? Colors.green
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(title,
            style: TextStyle(color: Colors.white))),
    );
  }

}