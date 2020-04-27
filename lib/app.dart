import 'package:flutter/material.dart';
import 'package:flutter_console/model/account.dart';
import 'package:flutter_console/page/index.dart';
import 'package:flutter_console/provider/index.dart';
import 'package:flutter_console/router/application.dart';
import 'package:flutter_console/services/index.dart';
import 'package:flutter_console/services/util.dart';
import 'package:provider/provider.dart';
import './services/index.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    getMy();
  }

  Future getMy() async {
    HttpUtil.get(accountService['my']).then((value) {
      final res = MyModel.fromJson(value);
      Provider.of<AccountProvider>(context, listen: false).saveMy(res);
      print('app::: $res');
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Console',
        // navigatorKey: Constants.navigatorKey,
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(
            primaryColor: Colors.black,
            buttonTheme: ButtonThemeData(
                height: 50,
                buttonColor: Color.fromRGBO(0, 0, 0, 0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22.0)),
                ),
                textTheme: ButtonTextTheme.primary)),
        home: Loading());
  }
}
