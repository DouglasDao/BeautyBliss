import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:beautybliss/Dashboard.dart';
import 'package:beautybliss/NewBooking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/**
 * Author: Douglas BR
 * Date: 23 Jun 2020
 */

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/NewBooking': (context) => NewBooking(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF000000),
        ),
        home: Scaffold(
          backgroundColor: Color(0xFF0A0E21),
          body: InitScreenStateFul(),
        )
    );
  }
}

class InitScreenStateFul extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InitScreen();
  }
}

class InitScreen extends State {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
    debugPrint("initState==========");
    Future.delayed(const Duration(seconds: 3), () =>
        BeautyBlissUtils(mContext: context).routeWidgetWithSlide(Dashboard())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
                child: BeautyBlissUtils(mContext: context).setText('Beautyblissbydivs', 32.0, 'Srisakdi')
            ),
            flex: 12,
          ),
          Expanded(
            child: BeautyBlissUtils(mContext: context).setText('Divya - Makeup & Hair!', 22.0, 'Lovers Quarrel'),
            flex: 1,
          )
        ],
      ),
    );
  }
}
