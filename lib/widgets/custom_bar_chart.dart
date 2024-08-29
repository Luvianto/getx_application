import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:getx_application/widgets/custom_card.dart';

class CustomBarChart extends StatelessWidget {
  final String title;
  final String subtitle;
  final Map<String, double> dataValues;

  const CustomBarChart({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dataValues,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> keys = dataValues.keys.toList();
    final List<double> values = dataValues.values.toList();

    return CustomCard(
      title: title,
      subtitle: subtitle,
      listWidget: [
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(
                border: Border.all(color: Colors.grey),
              ),
              gridData: const FlGridData(
                drawVerticalLine: false,
                horizontalInterval: 250,
              ),
              barGroups: List.generate(
                values.length,
                (index) => BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: values[index],
                      color: Theme.of(context).colorScheme.primary,
                      width: values.length < 7
                          ? 40
                          : values.length < 10
                              ? 30
                              : 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                ),
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 35,
                    interval: 250,
                    // getTitlesWidget: (value, meta) {
                    //   if (
                    //       value == 250 ||
                    //       value == 500 ||
                    //       value == 750 ||
                    //       value == 1000) {
                    //     return Text(
                    //       value.toInt().toString(),
                    //       style: Theme.of(context).textTheme.displaySmall,
                    //     );
                    //   }
                    //   return const SizedBox.shrink();
                    // },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() < keys.length) {
                        return Text(
                          keys[value.toInt()],
                          style: Theme.of(context).textTheme.displaySmall,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.toString(),
                      Theme.of(context).textTheme.bodyLarge!,
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
