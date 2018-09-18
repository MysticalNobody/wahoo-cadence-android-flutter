import 'dart:async';
import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oculus_vr_demo/routes.dart';

const platform = const MethodChannel('team.itis/velo');

class InfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InfoScreenState();
  }
}

var rpm = '0';
var revs = '0';
var prevRpm = '0';
var prevRevs = '0';

class InfoScreenState extends State<InfoScreen> {
  Future<Null> getData() async {
    try {
      var data = await platform.invokeMethod('getData');
      if (data != null) {
        setState(() {
          if (rpm == '0' && revs == '0') {
            rpm = data['Rpm'];
            revs = data['CrankRevs'];
          } else {
            prevRpm = rpm;
            prevRevs = revs;
            rpm = data['Rpm'];
            revs = data['CrankRevs'];
          }
        });
      }
      new Timer(Duration(seconds: 1), () {
        getData();
      });
    } on PlatformException catch (e) {}
  }

  @override
  void initState() {
    getData();
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
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Hero(
                          tag: 'status',
                          child: new Material(
                              color: Colors.transparent,
                              child: Text(
                                'Подключено',
                                style: TextStyle(
                                    color: Colors.white.withAlpha(220),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ))))),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(children: <Widget>[
                              Text(
                                'Количество оборотов',
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(revs,
                                        style: TextStyle(
                                            color: Colors.white.withAlpha(220),
                                            fontSize: 36.0,
                                            fontWeight: FontWeight.w900))
                                  ])
                            ]),
                            Container(
                                margin: EdgeInsets.only(top: 48.0),
                                child: Column(children: <Widget>[
                                  Text('Скорость',
                                      style: TextStyle(color: Colors.white)),
                                  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('$rpm rpm',
                                            style: TextStyle(
                                                color:
                                                    Colors.white.withAlpha(220),
                                                fontSize: 36.0,
                                                fontWeight: FontWeight.w900)),
                                        Icon(
                                          double.parse(rpm) >
                                                  double.parse(prevRpm)
                                              ? Icons.arrow_upward
                                              : Icons.arrow_downward,
                                          color: Colors.white.withAlpha(100),
                                          size: 36.0,
                                        )
                                      ]),
                                ]))
                          ],
                        )
                      ]))
            ])));
  }
}
