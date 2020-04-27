import 'package:flutter/material.dart';
import 'package:flutter_console/model/homekit.dart';
import 'package:flutter_console/page/homekit/home-item.dart';
import 'package:flutter_console/services/index.dart';
import 'package:provider/provider.dart';
import '../../provider/index.dart';
class HomeKitPage extends StatefulWidget {
  @override
  _HomeKitPageState createState() => _HomeKitPageState();
}

class _HomeKitPageState extends State<HomeKitPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  int _selectIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: Provider.of<HomeKitProvider>(context, listen: false)
            .homeList
            .length,
        vsync: this); // 注册tab控制器
    _tabController.addListener(() {
      _selectIndex = _tabController.index;
      print(_selectIndex);
    });
    getHomeList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future getHomeList() async {
    HttpUtil.getList(oaService['getHome'], data: {'page': 1, 'limit': 99}).then((homeList) async {
      if (homeList.length >= 0) {
        List<HomeModel> _homeList = [];
        homeList.forEach((e) => _homeList.add(HomeModel.fromJson(e)));
        Provider.of<HomeKitProvider>(context, listen: false)
            .saveHomeList(_homeList);
        _tabController =
            TabController(length: _homeList.length, vsync: this); // 注册tab控制器

        await getAllRooms(_homeList);
      }
    }).catchError((err) {
      Provider.of<HomeKitProvider>(context, listen: false).saveHomeList([]);
      Provider.of<HomeKitProvider>(context, listen: false).saveRoomList([]);
    });
  }

  Future getAllRooms (List<HomeModel> hList) async {
    Future.wait(
        hList.map((h) => HttpUtil.getList(oaService['getRoom'], data: {
            'page': 1,
            'limit': 1000000000,
            'search': 'homeID:${h.sId}'
          })).toList()
      ).then((rList) {
        if (rList.length >= 0) {
          List<List<RoomModel>> result = [];
          rList.forEach((list) {
            List<RoomModel> l = [];
            list.forEach((r) => l.add(RoomModel.fromJson(r)));
            result.add(l);
          });
          Provider.of<HomeKitProvider>(context, listen: false)
              .saveRoomList(result);
        }
      });
  }

  List<Widget> tabBar(List<HomeModel> hList) {
    return hList.map((h) {
      return Tab(text: h.cnName);
    }).toList();
  }

  List<Widget> tabBarView(List<HomeModel> hList) {
    List<List<RoomModel>> roomList =
        Provider.of<HomeKitProvider>(context).roomList;
    return hList.asMap().keys.map((int homeIndex) {
      if (roomList.length > 0) {
        List<RoomModel> itemRoomList = roomList[homeIndex];
        return ListView.builder(
            itemCount: itemRoomList.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemHoom(
                  room: itemRoomList[index], homeId: hList[homeIndex].sId);
            });
      }
      return Center(child: Text(hList[homeIndex].cnName));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<HomeModel> homeList = Provider.of<HomeKitProvider>(context).homeList;
    return homeList.length > 0
        ? Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: TabBar(
                  controller: _tabController,
                  tabs: tabBar(homeList),
                )),
            body: Consumer<HomeKitProvider>(builder: (BuildContext context,
                HomeKitProvider homeKitProvider, Widget child) {
              List<HomeModel> l = homeKitProvider.homeList;
              return TabBarView(
                controller: _tabController,
                children: tabBarView(l),
              );
            }))
        : Scaffold(
            body: Center(child: Text('loading...')),
          );
  }
}