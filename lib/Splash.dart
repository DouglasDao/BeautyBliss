import 'package:beautybliss/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(Splash());

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
        home: Scaffold(
          body: InitScreenStateFul(),
        ));
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
    super.initState();
    debugPrint("initState==========");
    Future.delayed(const Duration(seconds: 3), () =>
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                Dashboard()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build==========");
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: _setText('Beautyblissbydivs', 'Srisakdi')
            ),
            flex: 12,
          ),
          Expanded(
            child: _setText('Divya - Makeup & Hair!', 'Lovers Quarrel'),
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget _setText(String text, String fontFamily) {
    return Text(text, style: TextStyle(fontSize: 32.0, fontFamily: fontFamily));
  }
}
