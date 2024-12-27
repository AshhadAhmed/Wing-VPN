// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class LanguagePageRadioProvider with ChangeNotifier {
  int _selectedValue = 0;

  int get selectedValue => _selectedValue;

  void setSelectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }
}
