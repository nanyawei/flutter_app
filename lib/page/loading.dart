import 'package:flutter/material.dart';
import 'package:flutter_console/model/account.dart';
import 'dart:async';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../router/application.dart';
import '../provider/index.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 2), () {
        // 使用路由跳转到应用主页面
        checkIsLogin();
      }
    );
  }

  Future checkIsLogin() async {
    final SharedPreferences prefs = await _prefs;
    final String headerToken = prefs.getString('headerToken');
    if (headerToken == null) {
      return Application.router.navigateTo(context, 'login');
    }
    MyModel my = Provider.of<AccountProvider>(context, listen: false).my;
    if (my == null) {
      return Application.router.navigateTo(context, 'login');
    }
    return Application.router.navigateTo(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (BuildContext context, AccountProvider accountProvider,
          Widget child) {
        return Center(
          child: Stack(children: <Widget>[
            Image.asset('images/loading.jpg'),
            Positioned(
                top: 100,
                child: Container(
                    width: 400,
                    child: Center(
                        child: Text('Console',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.none)))))
          ]),
        );
      },
    );
  }
}