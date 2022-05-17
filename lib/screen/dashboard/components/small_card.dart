import 'package:calorie_mobile/screen/dashboard/components/base_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final String title;
  final String label;
  final String value;
  final String comparedValue;

  const SmallCard({Key? key, required this.title, this.label="", required this.value, this.comparedValue=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 170,
        child: BaseCard(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title!="")
              Text(title, style: Theme.of(context).textTheme.labelSmall),
            if (value!="")
              Text(value, style: Theme.of(context).textTheme.labelLarge),
            if (label!="")
              Text(label, style: Theme.of(context).textTheme.labelMedium),
          ],
        )));
  }

}