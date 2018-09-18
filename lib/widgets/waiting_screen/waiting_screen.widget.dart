import 'dart:async';
import 'dart:io';

import 'package:fluro/fluro.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oculus_vr_demo/routes.dart';

const platform = const MethodChannel('team.itis/velo');

class WaitingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WaitingScreenState();
  }
}

class WaitingScreenState extends State<WaitingScreen> {
  Future<Null> checkInfo() async {
    try {
      var connected = await platform.invokeMethod('checkConnect');
      if (connected) {
        Routes.navigateTo(context, '/info', transition: TransitionType.fadeIn);
      } else {
        new Timer(Duration(seconds: 1), () {
          checkInfo();
        });
      }
    } on PlatformException catch (e) {}
  }

  @override
  void initState() {
    checkInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: <Widget>[
              Positioned.fill(
                  child: Image.asset(
                'assets/bg.jpg',
                fit: BoxFit.fill,
              )),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Hero(
                                tag: 'status',
                                child: new Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      'Подключение... \n Пожалуйста, подождите',
                                      style: TextStyle(
                                          color: Colors.white.withAlpha(220),
                                          fontSize: 24.0),
                                      textAlign: TextAlign.center,
                                    )))),
                        Container(
                            margin: EdgeInsetsDirectional.only(top: 36.0),
                            child: SpinKitFoldingCube(
                              color: Colors.white,
                              size: 75.0,
                            ))
                      ]))
            ])));
  }
}
