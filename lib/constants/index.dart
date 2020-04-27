import 'package:flutter/material.dart';

class Constants {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigatorState => Constants.navigatorKey.currentState;
  BuildContext get currentContext => navigatorState.context;
  ThemeData get currentTheme => Theme.of(currentContext);
}
