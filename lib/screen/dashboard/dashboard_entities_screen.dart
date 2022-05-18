import 'package:calorie_mobile/movas/actions/entry_action.dart';
import 'package:calorie_mobile/movas/observables/entry_o.dart';
import 'package:calorie_mobile/screen/dashboard/components/daily_entry_chart.dart';
import 'package:calorie_mobile/screen/dashboard/components/weekly_entry_chart.dart';
import 'package:flutter/cupertino.dart';
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
    EntryAction.of(context).resetEntries();

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
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(88.0),
          child: AppBar(
            elevation: 2,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              background: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(right: 16, left: 16, top: 8),
                  color: Colors.white,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: widget.modes.map((String item) {
                              return InkWell(
                                onTap: (){
                                    setState(() {
                                        selectedMode = item;
                                    });

                                    if (item=="Weekly") {
                                        updateDateRange(getDefaultDateRange());
                                    } else {
                                        updateDateRange(dateRangeForToday());
                                    }
                                },
                                child: Text(item, style: TextStyle(
                                  color: selectedMode==item
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).textTheme.bodyText1?.color
                                ),),
                              );
                            }).toList(),
                          ),
                        ),
                        Divider(),
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
                                ? Center(
                                  child: Padding(
                              padding: const EdgeInsets.only(top: 4.0, bottom: 12),
                                    child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                    Text("Today"),
                                    Text(dateFormat.format(DateTime.now()))
                              ],
                            ),
                                  ),
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                ))]
              )),
            )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(4),
          child: Consumer<AllEntriesO>(
                      builder: (context, entries, __) {
                        return Column(
                          children: [
                            if (selectedMode=="Weekly")
                              WeeklyEntryChart(
                                allEntriesO: entries,
                                showDay: selectedDateRange?.duration.inDays==6,
                                startDate: selectedDateRange?.start ?? DateTime.now(),
                                endDate: selectedDateRange?.end ?? DateTime.now().add(Duration(days: 6)),
                                dailyCalLimit: entries.dailyCaloriesLimit,
                              )
                            else if (selectedMode=="Daily")
                              DailyEntryChart(
                                allEntriesO: entries,
                                selectedDate: selectedDateRange?.start ?? DateTime.now(),
                                dailyCalLimit: entries.dailyCaloriesLimit,
                              ),
                          if (selectedMode=="Weekly")
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme.of(context).backgroundColor,
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Average input: 123 cal"),
                                  Container(height: 5,),
                                  Text("Average daily : 2342 cal"),
                                  Container(height: 5,),
                                  Text("Daily remaining calory limit : ${entries.dailyCaloriesLimit} cal of ${entries.dailyCaloriesLimit} cal"),
                                  Container(height: 5,),
                                  Text("Remaining monthly budget : \$${entries.monthlyBudget} of \$${entries.monthlyBudget}")
                                ],
                              ),
                            )
                          ],
                        );
                      }
                  ),
        )

    );
  }

}