import 'package:calorie_mobile/movas/actions/entry_action.dart';
import 'package:calorie_mobile/movas/observables/entry_o.dart';
import 'package:calorie_mobile/screen/dashboard/components/entries_chart.dart';
import 'package:calorie_mobile/screen/dashboard/components/entries_table.dart';
import 'package:calorie_mobile/screen/dashboard/components/large_card.dart';
import 'package:calorie_mobile/screen/dashboard/components/notification_dialog.dart';
import 'package:calorie_mobile/screen/dashboard/components/small_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:calorie_mobile/screen/dashboard/components/base_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntitiesScreen extends StatefulWidget {

  final modes = ["Daily", "Weekly"];

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

  resetDateRange() {
    var monThisWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    setState(() {
      selectedDateRange = DateTimeRange(start: monThisWeek, end: monThisWeek.add(Duration(days: 6)));
    });
  }

  dateRangeForToday() {
    setState(() {
      selectedDateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());
    });
  }

  @override
  void initState() {
    resetDateRange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 16, bottom: 16),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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

                    if (newValue=="Weekly") {
                      resetDateRange();
                    } else {
                      dateRangeForToday();
                    }

                    EntryAction.of(context).getEntries(
                        fromDate: selectedDateRange?.start,
                        toDate: selectedDateRange?.end
                    );
                  },
                  value: selectedMode,
                ),
                InkWell(
                    onTap: () async {
                      if (selectedMode!="Daily") {
                        showDateRangePicker(
                          context: context,
                          lastDate: new DateTime.now(),
                          firstDate: new DateTime.now()
                              .subtract(Duration(days: 1000)),
                        ).then((value) => setState(() {
                          selectedDateRange = value;
                          EntryAction.of(context).getEntries(
                              fromDate: selectedDateRange?.start,
                              toDate: selectedDateRange?.end
                          );
                        }));
                      }
                    },
                    child: selectedMode=="Daily"
                        ? Text("Today")
                        : Text("${selectedDateRange?.start.toString()} to"
                        "${selectedDateRange?.end.toString()}")),
                  LargeCard(contentWidget:
                Consumer<AllEntriesO>(
                    builder: (context, entries, __) {
                      return EntriesChart(
                          allEntriesO: entries,
                          showDay: selectedDateRange?.duration.inDays==6,
                          startDate: selectedDateRange?.start ?? DateTime.now(),
                          endDate: selectedDateRange?.end ?? DateTime.now().add(Duration(days: 6)),
                          dailyCalLimit: entries.dailyCaloriesLimit,
                      );
                    }
                  ), title: "")
              ],
            ))
    );
  }

}