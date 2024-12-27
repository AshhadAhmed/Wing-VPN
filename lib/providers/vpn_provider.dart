// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';

import '../pages/main_page.dart';

class VpnProvider with ChangeNotifier {
  Timer? _timer;
  bool _isConnected = false;
  bool _isConnecting = false;
  Duration _connectionDuration = Duration.zero;
  ServerInfo _currentServer = ServerInfo(
    server: "United States",
    flag: AssetImage("assets/images/US_flag.jpg"),
  );

  bool get isConnected => _isConnected;
  bool get isConnecting => _isConnecting;
  String get connectionTime => _formatDuration(_connectionDuration);
  ServerInfo get currentServer => _currentServer; 

  void enableConnection() {
    if (!_isConnected) {
      _isConnecting = true;

      Future.delayed(Duration(seconds: 3), () {
        _isConnecting = false;
        _isConnected = true;
        _startTimer();
      });
    } else {
      disableConnection();
    }
    notifyListeners();
  }

  VpnProvider setServer(String server, ImageProvider? image) {
    _currentServer = ServerInfo(server: server, flag: image);
    notifyListeners();
    
    return this;
  }

  void disableConnection() {
    _isConnected = false;
    _connectionDuration = Duration.zero;
    _stopTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _connectionDuration += Duration(seconds: 1);
      notifyListeners();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
