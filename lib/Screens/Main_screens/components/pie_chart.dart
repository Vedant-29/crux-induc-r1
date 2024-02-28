import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:crux_induc/main.dart';

class UserPieChart extends StatefulWidget {
  final Map<String, double> data;
  final Map<String, Color> categoryColors;

  UserPieChart({required this.data, required this.categoryColors, Key? key}) : super(key: key);

  @override
  _UserPieChartState createState() => _UserPieChartState();
}

class _UserPieChartState extends State<UserPieChart> {
  final Map<String, Color> categoryColors = {
    'Food': Colors.red,
    'Transport': Colors.blue,
    'Entertainment': Color.fromARGB(255, 62, 8, 171),
    'Others': Colors.green,
    // Add more categories and colors as needed
  };

  @override
  Widget build(BuildContext context) {
    double totalSum = widget.data.values.fold(0, (a, b) => a + b);

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Total Value',
              style: TextStyle(
                color: Color.fromARGB(255,142,142,147),
                fontSize: 14,
                fontFamily: 'inter',
              ),  
            ),
            Text(
              'Rs.$totalSum',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 21,
                fontFamily: 'inter',
              ),  
            ),
          ],
        ),
        PieChart(
          PieChartData(
            sectionsSpace: 3.5,
            sections: widget.data.entries.map((entry) {
              double percentage;
              Color color;

              if (totalSum < 0 || entry.value < 0) {
                percentage = 0;
                color = Colors.red;
              } else if (widget.data.length == 1) {
                percentage = 100;
                color = categoryColors[entry.key] ?? Colors.grey;
              } else {
                percentage = entry.value / totalSum * 100;
                color = categoryColors[entry.key] ?? Colors.grey;
              }

              return PieChartSectionData(
                color: color,
                value: percentage,
                title: '${percentage.toStringAsFixed(1)}%',
                radius: 35,
                titleStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}