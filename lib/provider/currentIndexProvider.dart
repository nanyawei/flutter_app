import 'package:flutter/material.dart';

class CurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;

  void saveCurrentIndex (int index) {
    print('index:$index');
    currentIndex = index;
    notifyListeners();
  }
}