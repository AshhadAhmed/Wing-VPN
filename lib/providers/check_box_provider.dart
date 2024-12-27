// ignore_for_file: prefer_final_fields, unused_field, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CheckBoxProvider with ChangeNotifier {
  bool _isSwitched = false;

  bool get isSwitched => _isSwitched;

  void onTap(bool? value) {
    _isSwitched = value ?? false;
    notifyListeners();
  }
}
