import 'package:calorie_mobile/movas/observables/entry_o.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DailyEntryChart extends StatefulWidget {
  final AllEntriesO allEntriesO;
  final DateTime selectedDate;
  final double dailyCalLimit;

  DailyEntryChart({
    Key? key,
    required this.allEntriesO,
    required this.selectedDate,
    required this.dailyCalLimit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DailyEntryChartState();
  }
}

class DailyEntryChartState extends State<DailyEntryChart>{
  int touchedIndex = 0;
  late double totalConsumed;

  @override
  void didUpdateWidget(Widget oldWidget) {
    if ((oldWidget as DailyEntryChart).allEntriesO != widget.allEntriesO
        || (oldWidget as DailyEntryChart).selectedDate != widget.selectedDate
        || (oldWidget as DailyEntryChart).dailyCalLimit != widget.dailyCalLimit) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        countTotalPercentage();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    countTotalPercentage();
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
                  child:  (totalConsumed!=null) ? PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex =
                                    pieTouchResponse.touchedSection!.touchedSectionIndex;
                              });
                            }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        sections: showingSections()),
                  ) : Container(),

                ))));
  }

  countTotalPercentage() {
    var total = 0.0;
    for (var i in widget.allEntriesO.allEntries) {
      total += i.calories;
    }

    setState(() {
      totalConsumed = (total/widget.dailyCalLimit*100);
    });
  }

  double getExcessPercentage() {
    if (totalConsumed<=widget.dailyCalLimit)
      return 0.0;
    return (totalConsumed-widget.dailyCalLimit)/widget.dailyCalLimit*100;
  }

  double getRemainingLimitPercentage() {
    if (totalConsumed>=widget.dailyCalLimit)
      return 0.0;
    return (widget.dailyCalLimit-totalConsumed)/widget.dailyCalLimit*100;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: totalConsumed-getExcessPercentage(),
            title: '${(totalConsumed-getExcessPercentage()).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              label: 'Consumed',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: getExcessPercentage(),
            title: getExcessPercentage()<=0 ? '' : '${getExcessPercentage().toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              label: "Excess",
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: getRemainingLimitPercentage(),
            title: getRemainingLimitPercentage()<=0 ? '' : '${getRemainingLimitPercentage().toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              label: "Remaining",
              size: widgetSize,
              borderColor: const Color(0xff845bef),
            ),
            badgePositionPercentageOffset: 1.3,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final double size;
  final Color borderColor;
  final String label;

  const _Badge({
        Key? key,
    required this.label,
        required this.size,
        required this.borderColor,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Text(label),
      ),
    );
  }
}