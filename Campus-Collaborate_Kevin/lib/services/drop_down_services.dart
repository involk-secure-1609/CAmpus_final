import 'package:flutter/material.dart';

class DropDownServices extends ChangeNotifier {
  static final List<String> durationItems = [
    "Days",
    "Weeks",
    "Months",
    "Years"
  ];
  String _selectedValue = durationItems[2];

  void setValue(String value) {
    _selectedValue = value;
    notifyListeners();
  }

  void resetProvider(){
    _selectedValue = durationItems[2];
    notifyListeners();
  }

  String get selectedValue => _selectedValue;
}
