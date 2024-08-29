import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SemuaPelatihanChart extends StatelessWidget {
  const SemuaPelatihanChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(randomData());
  }
}

BarChartData randomData() {
  return BarChartData(
    maxY: 100.0,
    barTouchData: BarTouchData(enabled: false),
    titlesData: const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getTitles,
          reservedSize: 45,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          showTitles: true,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    barGroups: List.generate(
      12,
      (i) => makeGroupData(
        i,
        Random().nextInt(90).toDouble() + 10,
      ),
    ),
    gridData: const FlGridData(show: false),
  );
}

Widget getTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    // fontWeight: FontWeight.bold,
    fontSize: 11,
    fontFamily: 'Poppins-Light',
  );

  List<String> days = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Ags',
    'Sep',
    'Okt',
    'Nov',
    'Des'
  ];

  Widget text = Text(
    days[value.toInt()],
    style: style,
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 14,
    child: text,
  );
}

BarChartGroupData makeGroupData(
  int x,
  double y,
) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: x >= 6 ? Colors.transparent : const Color(0xff25324A),
        borderRadius: BorderRadius.zero,
        borderDashArray: null,
        width: 20,
        // borderSide: const BorderSide(color: Color(0xff25324A), width: 2.0),
      ),
    ],
  );
}
