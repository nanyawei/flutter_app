import 'package:flutter/material.dart';
import 'package:flutter_console/model/homekit.dart';
import 'package:flutter_console/page/homekit/component/curtain.dart';
import 'package:flutter_console/page/homekit/component/door.dart';
import 'package:flutter_console/page/homekit/component/group-lamp.dart';
import 'package:flutter_console/services/index.dart';
import '../../services/index.dart';

class RoomPage extends StatefulWidget {
  final String homeID;
  final String roomId;
  RoomPage({Key key, @required this.homeID, @required this.roomId})
      : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<GroupLampModel> groupLampList;
  List<DoorModel> doorList;
  List<CurtainModel> curtainList;

  @override
  void initState() {
    super.initState();
    _request();
  }

  void _request() async {
    Future.wait(['groupLamp', 'door', 'curtain']
            .map((type) => sendReq(type))
            .toList())
        .then((device) {
      List<GroupLampModel> _gList = [];
      List<DoorModel> _dList = [];
      List<CurtainModel> _cList = [];
      if (device.length >= 0) {
        device[0].forEach((g) => _gList.add(GroupLampModel.fromJson(g)));
        device[1].forEach((d) => _dList.add(DoorModel.fromJson(d)));
        device[2].forEach((c) => _cList.add(CurtainModel.fromJson(c)));
      }
      setState(() {
        groupLampList = _gList;
        doorList = _dList;
        curtainList = _cList;
      });
    });
  }

  Future sendReq(String type) async =>
      HttpUtil.getList(oaService['getDevice'], data: {
        'page': 1,
        'limit': 999999999,
        'search': 'homeID:${widget.homeID} roomID:${widget.roomId} type:$type'
      });

  Widget listBuild(List list, String type) {
    if (list == null) {
      return Text('加载中...');
    }

    Widget wrapBuilder() {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: list.asMap().keys.map((index) {
          switch (type) {
            case ('groupLamp'):
              final g = list.cast<GroupLampModel>();
              return groupLamp(g[index]);
            case ('door'):
              return door(list[index]);
            case ('curtain'):
              return curtain(list[index]);
            default:
              return Text('无数据......');
          }
        }
      ).toList());
    }

    String titleBuilder() {
      if (type == 'groupLamp') {
        return '灯组';
      } else if (type == 'door') {
        return '门锁';
      }
      return '遮光帘/幕布';
    }

    return Column(
      children: [
        Align(
            child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
                child: Text(titleBuilder(), style: TextStyle(fontSize: 24.0)))),
        wrapBuilder()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('HOMEKIT')),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            listBuild(groupLampList, 'groupLamp'),
            // listBuild(doorList, 'door'),
            // listBuild(curtainList, 'curtain'),
          ],
        ));
  }
}
