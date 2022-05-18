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
import 'package:intl/intl.dart';

class EntitiesScreen extends StatefulWidget {

  final modes = ["Daily", "Weekly"];

  @override
  State<StatefulWidget> createState() {
    return EntitiesScreenState();
  }
}

class EntitiesScreenState extends State<EntitiesScreen> {
  String selectedMode = "Daily";
  late DateTimeRange selectedDateRange;
  bool hasShowPassedDailyLimitNotification = false;
  bool hasShowPassedMonthlyLimitNotification = false;
  final DateFormat dateFormat = DateFormat("dd MMM yy");

  DateTimeRange getDefaultDateRange() {
    var monThisWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    return DateTimeRange(start: monThisWeek, end: monThisWeek.add(Duration(days: 6)));
  }

  DateTimeRange dateRangeForToday() {
    return DateTimeRange(start: DateTime.now(), end: DateTime.now());
  }

  updateDateRange(DateTimeRange newDateTimeRange) {
    setState(() {
      selectedDateRange = newDateTimeRange;
    });

    EntryAction.of(context).getEntries(
        fromDate: selectedDateRange?.start,
        toDate: selectedDateRange?.end
    );
  }

  @override
  void initState() {
    updateDateRange(getDefaultDateRange());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 16, left: 16),
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
                      updateDateRange(getDefaultDateRange());
                    } else {
                      updateDateRange(dateRangeForToday());
                    }

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
                        ).then((value) {
                          if (value!=null) {
                            updateDateRange(selectedDateRange);
                          }
                        });
                      }
                    },
                    child: selectedMode=="Daily"
                        ? Column(
                      mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Today"),
                            Text(dateFormat.format(DateTime.now()))
                          ],
                        )
                        : Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 16),
                          child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                  onTap: (){
                                    var weekBeforeCurrent = DateTimeRange(
                                        start: selectedDateRange.start.subtract(Duration(days: 7)),
                                        end: selectedDateRange.end.subtract(Duration(days: 7)));
                                    updateDateRange(weekBeforeCurrent);
                                  },
                                  child: Icon(Icons.arrow_left)),
                              Text("${dateFormat.format(selectedDateRange.start)} - "
                              "${dateFormat.format(selectedDateRange.end)}"),
                              InkWell(
                                  onTap: (){
                                    var weekAfterCurrent = DateTimeRange(
                                        start: selectedDateRange.start.add(Duration(days: 7)),
                                        end: selectedDateRange.end.add(Duration(days: 7)));
                                    updateDateRange(weekAfterCurrent);
                                  },
                                  child: Icon(Icons.arrow_right)),
                            ],
                          ),
                        )),
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
                )
              ],
            ))
    );
  }

}