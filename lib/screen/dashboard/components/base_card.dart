import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget child;

  const BaseCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 16, top: 16),
      child: child,
    );
  }


}