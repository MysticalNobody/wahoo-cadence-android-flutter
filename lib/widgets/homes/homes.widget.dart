import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "./homes.view.dart";

var bluetoothState;
const platform = const MethodChannel('team.itis/velo');
Future<Null> connectWithSensor() async {
  try {
    final int result = await platform.invokeMethod('connectWithSensor');
  } on PlatformException catch (e) {}
}

class Homes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomesState();
  }
}

class HomesState extends State<Homes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: homesViewBuild(context));
  }
}
