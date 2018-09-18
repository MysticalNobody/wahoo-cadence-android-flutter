import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oculus_vr_demo/routes.dart';
import 'package:oculus_vr_demo/widgets/homes/homes.widget.dart';

void main() {
  Routes.initRoutes();
  startHome();
}

void startHome() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new MaterialApp(
    title: "Demo",
    home: new Homes(),
  ));
}
