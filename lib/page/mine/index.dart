import 'package:flutter/material.dart';
import 'package:flutter_console/model/account.dart';
import 'package:flutter_console/page/mine/mine-edit.dart';
import 'package:flutter_console/provider/index.dart';
import 'package:flutter_console/router/application.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    MyModel my = Provider.of<AccountProvider>(context, listen: false).my;

    void _logout() async {
      Provider.of<AccountProvider>(context, listen: false).saveMy(null);
      Provider.of<CurrentIndexProvider>(context, listen: false).saveCurrentIndex(0);

      SharedPreferences _pres = await SharedPreferences.getInstance();
      _pres.setString('headerToken', null);

      Application.router.navigateTo(context, 'login');
    }

    if (my == null) {
      return Center(child: Text('loading...'));
    }

    return Container(
        child: ListView(children: [
                Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(my.firstname),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      title: Text(my.chinesename),
                      subtitle: Text(my.email),
                      trailing: IconButton(icon: Icon(Icons.dehaze), onPressed: () => Application.router.navigateTo(context, '/my/edit')),
                    )),
                Divider(),
                Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: SizedBox(
                      child: RaisedButton(
                          onPressed: _logout,
                          child: Text('退 出'),
                          color: Theme.of(context).primaryColor),
                    ))
              ]));
  }
}
