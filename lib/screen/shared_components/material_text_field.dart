import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? suffix;
  final String? prefix;
  final TextEditingController? controller;
  final bool disable;
  final TextInputType? keyboardType;
  final String Function(String?)? validator;

  const MaterialTextField({Key? key, this.validator, this.label, this.hint, this.controller, this.disable=false, this.suffix, this.prefix, this.keyboardType}) : super(key: key);

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
            child: TextFormField(
              validator: (_) => validator?.call(_),
              keyboardType: keyboardType!=null ? keyboardType : null,
              enabled: !disable,
              controller: controller,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                suffix: suffix != null ? Text(suffix!) : null,
                prefix: prefix != null ? Text(prefix!) : null,
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