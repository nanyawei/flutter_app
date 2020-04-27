import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_console/app.dart';
import 'package:flutter_console/provider/index.dart';
import 'package:flutter_console/router/application.dart';
import 'package:flutter_console/router/index.dart';
import 'package:flutter_console/services/index.dart';
import 'package:provider/provider.dart';

void main(){
  HttpUtil();
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(Root());
}

class Root extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => HomeKitProvider()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider())
      ],
      child: App()
    );
  }
}