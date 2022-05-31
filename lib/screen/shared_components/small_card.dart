import 'package:calorie/config/dashboard_config.dart';
import 'package:calorie/screen/shared_components/base_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final String title;
  final String label;
  final String value;
  final String comparedValue;
  final Color? compareValueColor;

  const SmallCard({Key? key, required this.title, this.label="", required this.value, this.comparedValue="", this.compareValueColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 120,
        child: BaseCard(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title!="")
              Text(title, style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12
              )),
            if (value!="")
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 4),
                child: Text(value, style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                    color: AdminTheme.primaryTextColor
                )),
              ),
            if (label!="")
              Text(label, style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AdminTheme.primaryTextColor
              )),
            if (comparedValue!="")
              Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: Text(comparedValue, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AdminTheme.primaryTextColor
                ).copyWith(
                    fontWeight: FontWeight.bold, color: compareValueColor ?? Colors.black, fontSize: 10)),
              ),
          ],
        )));
  }

}