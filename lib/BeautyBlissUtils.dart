import 'package:flutter/material.dart';

class BeautyBlissUtils {
  BuildContext mContext;

  BeautyBlissUtils({this.mContext});

  void startWidget(Widget screen) {
    Navigator.of(mContext).push(_createRoute(screen));
  }

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void finish() {
    Navigator.pop(mContext);
  }
}
