// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class FavouriteServersProvider extends ChangeNotifier {
  List<String> _favourites = [];
  List<ImageProvider> _flags = [];
  List<ImageProvider> _strengths = [];

  List<String> get favourites => List.unmodifiable(_favourites);
  List<ImageProvider> get flags => List.unmodifiable(_flags);
  List<ImageProvider> get strengths => List.unmodifiable(_strengths);

  void addFavouriteServer(
    String server,
    ImageProvider flag,
    ImageProvider serverStrength,
  ) {
    _favourites.add(server);
    _flags.add(flag);
    _strengths.add(serverStrength);
    notifyListeners();
  }

  void removeFavouriteServer(String server) {
    int index = _favourites.indexOf(server);

    if (index != -1) {
      _favourites.removeAt(index);
      _flags.removeAt(index);
      _strengths.removeAt(index);
      notifyListeners();
    }
  }
}
