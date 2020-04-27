import 'package:flutter/material.dart';
import 'package:flutter_console/model/account.dart';

class AccountProvider with ChangeNotifier {
  MyModel my;
  String lastLoginAccount;

  // 记录上次登录用户名
  void saveLastLoginAccount (String account) {
    lastLoginAccount = account;
    notifyListeners();
  }

  // 保存自己的信息
  void saveMy (MyModel account) {
    print('account: $account');
    my = account;
    notifyListeners();
  }
}