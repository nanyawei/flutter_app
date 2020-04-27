import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_console/page/not_found.dart';
import 'package:flutter_console/router/router-handler.dart';

class Routes {
  static configureRoutes (Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return NotFoundPage();
      }
    );
    routerHandler.forEach((path, handler) {
      router.define(path, handler: handler, transitionType: TransitionType.inFromRight);
    });
  }
}