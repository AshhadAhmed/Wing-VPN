// ignore_for_file: prefer_final_fields, unused_field

import 'dart:async';

import 'package:flutter/material.dart';

class LinearProgressProvider with ChangeNotifier {
  double _progress = 0.0;

  double get progress => _progress;

  void initiateProgress(VoidCallback onComplete) {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      _progress += 0.05;

      // 0.0 to 1.0
      if (_progress >= 1.0) {
        timer.cancel();
        onComplete();
      }
      notifyListeners();
    });
  }
}
