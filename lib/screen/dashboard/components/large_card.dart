import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_card.dart';

class LargeCard extends StatelessWidget {
  final Widget contentWidget;
  final String title;

  const LargeCard({Key? key, required this.contentWidget, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall,),
            Divider(),
            if (contentWidget!=null)
              contentWidget
          ],
        ));
  }

}