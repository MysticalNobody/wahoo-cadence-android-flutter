import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:oculus_vr_demo/widgets/info_screen/info_screen.widget.dart';
import 'package:oculus_vr_demo/widgets/waiting_screen/waiting_screen.widget.dart';

class Routes {
  static Router _router = new Router();

  static void initRoutes() {
    _router.define("/waiting", handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new WaitingScreen();
    }));
    _router.define("/info", handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new InfoScreen();
    }));
  }

  static Future<dynamic> navigateTo(BuildContext context, String route,
      {TransitionType transition = TransitionType.fadeIn, bool replace = false}) {
    return _router.navigateTo(context, route, replace: replace, transition: transition);
  }

  static void backTo(BuildContext context, String path) {
    Navigator.of(context).popUntil((Route<dynamic> route) {
      return route == null || route is ModalRoute && route.settings.name == path;
    });
  }
}
