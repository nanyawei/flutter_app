import 'package:flutter/material.dart';
import 'package:flutter_console/model/account.dart';
import 'package:flutter_console/router/application.dart';
import 'package:flutter_console/services/index.dart';
import 'package:flutter_console/services/util.dart';
import 'package:provider/provider.dart';
import '../../services/account.dart';
import '../../provider/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool pwdShow = false;
  FocusNode _accountFocusNode = FocusNode();
  FocusNode _pwdFocusNode = FocusNode();
  RegExp pwdReg = new RegExp("@quantibio.com\$");
  TextEditingController _accountContorller = TextEditingController();
  TextEditingController _pwdContorller = TextEditingController();

  @override
  void dispose() {
    _accountFocusNode.unfocus();
    _pwdFocusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String lastAccount = Provider.of<AccountProvider>(context).lastLoginAccount;
    final size = MediaQuery.of(context).size;
    // final width = size.width;
    final height = size.height;
    return Scaffold(
        appBar: AppBar(title: Text('登陆账号'), leading: Icon(Icons.home)),
        body: ListView(
            padding:
                EdgeInsets.only(top: height * 0.12, right: 20.0, left: 20.0),
            children: <Widget>[
              Center(
                  child: Text(
                'CONSOLE',
                style: TextStyle(fontSize: 24),
              )),
              Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    // initialValue: Provider.of<AccountProvider>(context).lastLoginAccount,
                    autovalidate: true,
                    focusNode: _accountFocusNode,
                    controller: _accountContorller,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: '邮箱账号',
                        prefixIcon: Icon(Icons.person)),
                    validator: (v) {
                      if (v.isEmpty) {
                        return '请输入登录账号';
                      }
                      if (!pwdReg.hasMatch(v)) {
                        return '账号格式以 `@quantibio.com` 结尾';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidate: true,
                    focusNode: _pwdFocusNode,
                    controller: _pwdContorller,
                    decoration: new InputDecoration(
                        labelText: 'Password',
                        hintText: '密码',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(!pwdShow
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                pwdShow = !pwdShow;
                              });
                            })),
                    obscureText: !pwdShow,
                    validator: (v) {
                      if (v.isEmpty) {
                        return '请输入密码';
                      }
                      if (v.length < 6) {
                        return '密码不少于6位';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          _accountFocusNode.unfocus();
                          _pwdFocusNode.unfocus();
                          if (_formKey.currentState.validate()) {
                            HttpUtil.post(getToken, data: {
                              'loginname': _accountContorller.text,
                              'password': _pwdContorller.text
                            }).then((value) async {
                              Provider.of<AccountProvider>(context,
                                      listen: false)
                                  .saveLastLoginAccount(
                                      _accountContorller.text);

                              await HttpUtil.get(accountService['my'])
                                  .then((myRes) {
                                print('myRes::: $myRes');

                                if (myRes != null) {
                                  Provider.of<AccountProvider>(context,
                                          listen: false)
                                      .saveMy(MyModel.fromJson(myRes));
                                  Application.router.navigateTo(context, '/');
                                } else {
                                  Application.router
                                      .navigateTo(context, 'login');
                                }
                              }).catchError((e) {
                                print('my: eeee:  $e');
                              });
                            });
                          }
                        },
                        child: Text(
                          '登 录',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ]));
  }
}
