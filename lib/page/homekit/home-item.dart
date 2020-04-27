import 'package:flutter/material.dart';
import 'package:flutter_console/model/homekit.dart';
import 'package:flutter_console/router/application.dart';
import 'package:flutter_console/services/util.dart';

class ItemHoom extends StatefulWidget {
  final String homeId;
  final RoomModel room;
  ItemHoom({Key key, @required this.room, @required this.homeId}) : super(key: key);

  @override
  _ItemHoomState createState() => _ItemHoomState();
}

class _ItemHoomState extends State<ItemHoom> {
  final String image = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Application.router.navigateTo(context, '${widget.homeId}/room/${widget.room.sId}');
      },
        child: Container(
          margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
          child: Column(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'images/image-loading.png',
                image: '${Api.baseApi}attachment/d/${widget.room.imageUrl}',
                fit: BoxFit.fitWidth,
                height: 200.0,
              ),
              Text(
                widget.room.cnName
              )
            ],
          ),
      )
    );
  }
}
