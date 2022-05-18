import 'package:calorie_mobile/movas/observables/entry_o.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EntriesChart extends StatefulWidget {
  final AllEntriesO allEntriesO;
  final bool showDay;
  final DateTime startDate;
  final DateTime endDate;

  EntriesChart({
    Key? key,
    required this.allEntriesO,
    this.showDay=true,
    required this.startDate,
    required this.endDate}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EntriesChartState();
  }
}

class EntriesChartState extends State<EntriesChart> {
  List<BarChartGroupData> showingBarGroups = [];
  final double barWidth = 7;
  final double barSpace = 4;

  @override
  void initState() {
    showingBarGroups = showingGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 38,
                  ),
                  const Text(
                    'Transactions',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'state',
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 20,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
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
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return Text(text, style: style);
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          'Mn',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          'Te',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          'Wd',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          'Tu',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          'Fr',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          'St',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          'Sn',
          style: style,
        );
        break;
      default:
        text = const Text(
          '',
          style: style,
        );
        break;
    }
    return Padding(padding: const EdgeInsets.only(top: 20), child: text);
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(barsSpace: barSpace, x: x, barRods: [
      BarChartRodData(
          toY: y1,
          color: y1>1500 ? Colors.red : Colors.green,
          width: barWidth
      )
    ]);
  }

  List<BarChartGroupData> showingGroups() {
    var showingBarGroups = List.generate(
        widget.endDate.difference(widget.startDate).inDays+1, (index) => makeGroupData(index, 0));

    for (var i in widget.allEntriesO.allEntries) {
      int index = i.createdAt.difference(widget.startDate).inDays + 1;
      double agrCalories = i.calories + showingBarGroups[index].barRods[0].toY;
      showingBarGroups.removeAt(index);
      showingBarGroups.insert(index, makeGroupData(index, agrCalories));
    }

    return showingBarGroups!;
  }

}