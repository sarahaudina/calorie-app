import 'package:calorie_mobile/screen/dashboard/components/entries_table.dart';
import 'package:calorie_mobile/screen/dashboard/components/large_card.dart';
import 'package:calorie_mobile/screen/dashboard/components/small_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:calorie_mobile/screen/dashboard/components/base_card.dart';
import 'package:flutter/material.dart';

class EntitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 16, bottom: 16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallCard(title: "Average", value: "1500", label: "cal"),
            LargeCard(contentWidget: EntriesTable(), title: "Recent Entries"),
        ],
    ),
      ),);
  }

}