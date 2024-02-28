import 'package:flutter/material.dart';

class PieChartColors extends ChangeNotifier {
  Map<String, Color> _colors = {
    'Food': Colors.red,
    'Transport': Colors.blue,
    'Entertainment': Color.fromARGB(255, 179, 2, 105),
    'Others': Colors.green,
    // Add more categories and colors as needed
  };

  Map<String, Color> get colors => _colors;

  void initializeColors() {
    _colors = {
      'Food': Colors.red,
      'Transport': Colors.blue,
      'Entertainment': Color.fromARGB(255, 179, 2, 105),
      'Others': Colors.green,
      // Add more categories and colors as needed
    };
    notifyListeners();
  }
}