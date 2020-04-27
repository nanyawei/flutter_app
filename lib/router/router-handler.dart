import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_console/page/index.dart';
import 'package:flutter_console/page/mine/mine-edit.dart';

final Map<String, Handler> routerHandler = {
  '/loading': Handler(handlerFunc: (BuildContext context, params) {
    return Loading();
  }),
  '/login': Handler(handlerFunc: (BuildContext context, params) {
    return LoginPage();
  }),
  '/': Handler(handlerFunc: (BuildContext context, params) {
    return IndexPage();
  }),
  '/:homeID/room/:roomID': Handler(handlerFunc: (BuildContext context, params) {
    return RoomPage(homeID: params['homeID'][0], roomId: params['roomID'][0]);
  }),
  '/my': Handler(handlerFunc: (BuildContext context, params) {
    return MinePage();
  }),
  '/my/edit': Handler(handlerFunc: (BuildContext context, params) {
    return MineDetail();
  }),
};

// typedef Widget HandlerFunc(BuildContext context, Map<String, List<String>> parameters);
// typedef Widget RouterBuilderFunc(Bundle bundle);

// class RouterBuilder{
//   final RouterBuilderFunc builder;
//   HandlerFunc handlerFunc;
//   RouterBuilder({this.builder}) {
//     this.handlerFunc = (context, _) {
//       return this.builder(ModalRoute.of(context).settings.arguments as Bundle);
//     };
//   }
//   Handler getHandler () {
//     return Handler(handlerFunc: this.handlerFunc);
//   }
// }
