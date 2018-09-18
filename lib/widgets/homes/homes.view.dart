import "package:flutter/material.dart";
import 'package:oculus_vr_demo/routes.dart';
import 'package:oculus_vr_demo/widgets/homes/homes.widget.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:fluro/fluro.dart';
import "../../styles/default.style.dart";
import "./homes.style.dart";

Widget homesViewBuild(context) {
  return Stack(children: <Widget>[
    Positioned.fill(
        child: Image.asset(
      'assets/bg.jpg',
      fit: BoxFit.fill,
    )),
    Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
                tag: 'status',
                child: new Material(
                    color: Colors.transparent,
                    child: Text(
                      'Для работы приложения, необходимо предоставить соответствующие разрешения',
                      style: TextStyle(
                          color: Colors.white.withAlpha(220), fontSize: 24.0),
                      textAlign: TextAlign.center,
                    ))),
            Container(
                margin: EdgeInsets.only(top: 28.0),
                child: FlatButton(
                  onPressed: () async {
                    var result = await SimplePermissions.requestPermission(
                        Permission.AccessFineLocation);
                    if (result) {
                      connectWithSensor();
                      Routes.navigateTo(context, '/waiting',
                          transition: TransitionType.fadeIn);
                    }
                  },
                  child: Text(
                    'Хорошо',
                    style: TextStyle(color: Colors.blue),
                  ),
                  color: Colors.white.withAlpha(100),
                ))
          ],
        ))
  ]);
}
