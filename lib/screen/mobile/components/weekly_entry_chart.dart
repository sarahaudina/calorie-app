import 'package:calorie/movas/observables/entry_o.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyEntryChart extends StatefulWidget {
  final AllEntriesO allEntriesO;
  final bool showDay;
  final DateTime startDate;
  final DateTime endDate;
  final double dailyCalLimit;


  WeeklyEntryChart({
    Key? key,
    required this.allEntriesO,
    this.showDay=true,
    required this.startDate,
    required this.endDate,
    required this.dailyCalLimit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WeeklyEntryChartState();
  }
}

class WeeklyEntryChartState extends State<WeeklyEntryChart> {
  List<BarChartGroupData> showingBarGroups = [];
  final double barWidth = 7;
  final double barSpace = 4;
  final dayLabels = ["Mon", "Th", "Wed", "Tue", "Fr", "Sat", "Sun"];
  late double maxY;

  @override
  void didUpdateWidget(Widget oldWidget) {
    if ((oldWidget as WeeklyEntryChart).allEntriesO != widget.allEntriesO
        || (oldWidget as WeeklyEntryChart).showDay != widget.showDay
        || (oldWidget as WeeklyEntryChart).startDate != widget.startDate
        || (oldWidget as WeeklyEntryChart).endDate != widget.endDate
        || (oldWidget as WeeklyEntryChart).dailyCalLimit != widget.dailyCalLimit) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        showingGroups();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showingGroups();
    });

    maxY = widget.dailyCalLimit;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      maxY: maxY ?? widget.dailyCalLimit,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.black,
                          getTooltipItem: (_a, _b, _c, _d) => null,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: bottomTitles,
                            reservedSize: 42,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          left: BorderSide(width: 0.5, color: Theme.of(context).primaryColorDark),
                          bottom: BorderSide(width: 0.5, color: Theme.of(context).primaryColorDark),
                        )
                      ),
                      barGroups: showingBarGroups,
                      gridData: FlGridData(show: false),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget leftTitles(double value, TitleMeta meta) {
    // return Container();
    var style = TextStyle(
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.w800,
      fontSize: 10,
    );
    String text = "";
    if (maxY == double.nan || value == double.nan) {
      return Container();
    } else if (value == 0) {
      text = '0 cal';
    } else if (value == maxY) {
      text = '${value.toInt()}';
    } else if (value == widget.dailyCalLimit) {
      text = '${value.toInt()}\n(daily limit)';
    } else {
      return Container();
    }

    return Container(
        width: 16,
        child: Text(text, style: style));
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: Theme.of(context).primaryColorDark,
      fontWeight: FontWeight.w800,
      fontSize: 10,
    );

    String text;

    var day = widget.startDate.add(Duration(days: value.toInt())).day;
    var month = widget.startDate.add(Duration(days: value.toInt())).month;
    text = "$day/$month";

    if (widget.showDay) {
      text = dayLabels[value.toInt()] + "\n" + text;
    }

    return Padding(padding: const EdgeInsets.only(top: 10), child: Text(text, style: style, textAlign: TextAlign.center,));
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(barsSpace: barSpace, x: x, barRods: [
      BarChartRodData(
          toY: y1,
          color: y1>widget.dailyCalLimit ? Colors.red : Colors.green,
          width: barWidth
      )
    ]);
  }

  showingGroups() {
    var showingBarGroups = List.generate(
        widget.endDate.difference(widget.startDate).inDays+1, (index) => makeGroupData(index, 0));

    for (var i in widget.allEntriesO.allEntries) {
      int index = i.createdAt.difference(widget.startDate).inDays.abs();
      double agrCalories = i.calories + showingBarGroups[index].barRods[0].toY;
      showingBarGroups.removeAt(index);
      showingBarGroups.insert(index, makeGroupData(index, agrCalories));
    }

    var maxy = widget.dailyCalLimit;
    for (var i in showingBarGroups) {
      if (i.barRods[0].toY > maxy) {
        maxy = i.barRods[0].toY;
      }
    }

    setState(() {
      maxY = maxy;
      this.showingBarGroups = showingBarGroups;
    });
  }

}