import 'package:flutter/material.dart';
import 'package:flutter_console/model/homekit.dart';

class HomeKitProvider with ChangeNotifier {
  List<HomeModel> homeList = [];
  List<List<RoomModel>> roomList = [];

  void saveHomeList (List<HomeModel> list) {
    print ('list: $list');
    homeList = list;
    notifyListeners();
  }

  void saveRoomList (List<List<RoomModel>> list) {
    roomList = list;
    notifyListeners();
  }

}