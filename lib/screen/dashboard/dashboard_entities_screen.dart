import 'package:calorie_mobile/movas/observables/entry_o.dart';
import 'package:calorie_mobile/screen/dashboard/components/entries_table.dart';
import 'package:calorie_mobile/screen/dashboard/components/large_card.dart';
import 'package:calorie_mobile/screen/dashboard/components/notification_dialog.dart';
import 'package:calorie_mobile/screen/dashboard/components/small_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:calorie_mobile/screen/dashboard/components/base_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntitiesScreen extends StatefulWidget {

  final modes = ["Daily", "Weekly", "Monthly", "Custom"];

  @override
  State<StatefulWidget> createState() {
    return EntitiesScreenState();
  }
}

class EntitiesScreenState extends State<EntitiesScreen> {
  String selectedMode = "Daily";
  DateTimeRange? selectedDateRange = null;
  bool hasShowPassedDailyLimitNotification = false;
  bool hasShowPassedMonthlyLimitNotification = false;
  bool _checkNotification = true;

  checkNotification(AllEntriesO allEntriesO) {
    if (allEntriesO.passDailyCaloriesLimit && !hasShowPassedDailyLimitNotification)
      showReminderDialog(context, "Reminder", "You have reached your daily caloty limit.");
    if (allEntriesO.passMonthlyBudget && !hasShowPassedMonthlyLimitNotification)
      showReminderDialog(context, "Reminder", "You have reached your monthly budget limit.");

    setState(() {
      _checkNotification = false;
    });
  }

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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                        items: widget.modes.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            selectedMode = newValue!;
                          });
                        },
                        value: selectedMode,
                    ),
                    if (selectedMode=="Custom")
                    InkWell(
                        onTap: () async {
                          final picked = await showDateRangePicker(
                            context: context,
                            lastDate: new DateTime.now(),
                            firstDate: new DateTime.now()
                                .subtract(Duration(days: 1000)),
                          );

                          setState(() {
                            selectedDateRange = picked;
                          });

                        },
                        child: selectedDateRange==null
                          ? Text("Selected date")
                          : Text("${selectedDateRange?.start.toString()} to"
                            "${selectedDateRange?.end.toString()}"))
                  ],

                ),
                LargeCard(contentWidget: Consumer<AllEntriesO>(
                  builder: (context, entries, __) {
                    // if (_checkNotification && entries!=null)
                    //   checkNotification(entries);
                    return EntriesTable(entries);
                  }
                ), title: "Recent Entries"),
              ],
            ))
    );
  }

}