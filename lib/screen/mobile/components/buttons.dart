import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  final String title;
  final Function tap;

  const GreenButton(this.title, this.tap);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => tap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.green
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(title,
            style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(color: Colors.white))),
    );
  }

}