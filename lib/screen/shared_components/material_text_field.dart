import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool disable;

  const MaterialTextField({Key? key, this.label, this.hint, this.controller, this.disable=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      padding: new EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              enabled: !disable,
              controller: controller,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                labelText: hint ?? "",
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              color: Colors.white,
              child: Text( label ?? ""),
            ),
          )
        ],
      ),
    );
  }

}