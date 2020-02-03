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
          body: InitScreen(),
        ));
  }
}

class InitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text('Beautybliss by divs!', style: TextStyle(fontSize: 32.0, fontFamily: 'Srisakdi')),
            ), flex: 12,
          ),
          Expanded(
            child: Text('Divya - Makeup & Hair!', style: TextStyle(fontSize: 22.0, fontFamily: 'Lovers Quarrel')),
            flex: 1,
          )
        ],
      ),
    );
  }
}
