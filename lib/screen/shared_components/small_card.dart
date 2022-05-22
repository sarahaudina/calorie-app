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
              Text(title, style: Theme.of(context).textTheme.labelSmall),
            if (value!="")
              Text(value, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 25)),
            if (label!="")
              Text(label, style: Theme.of(context).textTheme.labelSmall),
            if (comparedValue!="")
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text(comparedValue, style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: compareValueColor ?? Colors.black, fontSize: 10)),
              ),
          ],
        )));
  }

}