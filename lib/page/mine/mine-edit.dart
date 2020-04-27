import 'package:flutter/material.dart';
import 'package:flutter_console/model/account.dart';
import 'package:flutter_console/provider/index.dart';
import 'package:flutter_console/router/application.dart';
import 'package:provider/provider.dart';

class MineDetail extends StatefulWidget {
  @override
  _MineDetailState createState() => _MineDetailState();
}

class _MineDetailState extends State<MineDetail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _chinesenameController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _decriptionController = TextEditingController();

  bool isActive(String type) => type == 'active' ? true : false;
  String setActive(bool status) => status ? 'active' : 'blocked';

  @override
  void initState() {
    super.initState();
    _getMy();
  }

  void _getMy() async {
    print('获取用户信息');
    MyModel my = Provider.of<AccountProvider>(context, listen: false).my;
    print(my.email);
    _chinesenameController.text = my.chinesename;
    _firstnameController.text = my.firstname;
    _lastnameController.text = my.lastname;
    _emailController.text = my.email;
    _decriptionController.text = my.description;
  }

  Widget setFormItem(
      String label, TextEditingController _controller, Icon icon) {
    return TextFormField(
      controller: _controller,
      decoration:
          InputDecoration(icon: icon, labelText: label, hintText: '请填写$label'),
    );
  }

  Widget nodeSave() => Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
            child: Text('保 存'),
            onPressed: _save,
          )));

  void _save() {
    final my = Provider.of<AccountProvider>(context, listen: false).my;
    my.chinesename = _chinesenameController.text;
    my.lastname = _lastnameController.text;
    my.firstname = _firstnameController.text;
    my.email = _emailController.text;
    my.description = _decriptionController.text;
    Provider.of<AccountProvider>(context, listen: false).saveMy(my);
    Application.router.navigateTo(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('基本信息')),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 30.0),
                child: Consumer<AccountProvider>(
                  builder: (BuildContext context,
                      AccountProvider accountProvider, Widget child) {
                    MyModel my = accountProvider.my;
                    return Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        setFormItem(
                            '姓名', _chinesenameController, Icon(Icons.person)),
                        setFormItem(
                            '名', _firstnameController, Icon(Icons.note)),
                        setFormItem(
                            '姓', _lastnameController, Icon(Icons.portrait)),
                        setFormItem('邮箱', _emailController, Icon(Icons.email)),
                        setFormItem('描述', _decriptionController,
                            Icon(Icons.description)),
                        Row(
                          children: [
                            Icon(
                              Icons.build,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Align(
                                  child: Text(isActive(my.active)
                                      ? '活跃[${my.active}]'
                                      : '冻结[${my.active}]')),
                              flex: 2,
                            ),
                            Expanded(
                                child: Switch(
                                    value: isActive(my.active),
                                    onChanged: (status) {
                                      my.active = setActive(status);
                                      Provider.of<AccountProvider>(context,
                                              listen: false)
                                          .saveMy(my);
                                    }))
                          ],
                        ),
                        nodeSave()
                      ]),
                    );
                  },
                ))));
  }
}
