import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/Booking.dart';

/**
 * Author: Douglas BR
 * Date: 23 Jun 2020
 */

class BeautyBlissUtils {
  BuildContext mContext;

  BeautyBlissUtils({this.mContext});

  void routeWidget(Widget screen) {
    Navigator.of(mContext).push(_createRoute(screen));
  }

  Future routeResultWidget(String screen) async {
    return await Navigator.pushNamed(mContext, screen);
  }

  void materialRouteWidget(Widget routeScreen, Object data) {
    Navigator.push(mContext, MaterialPageRoute(builder: (context) => routeScreen, settings: RouteSettings(arguments: data)));
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
      });
  }

  void showSnackBar(GlobalKey<ScaffoldState> globalKey, String msg) {
    globalKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Color(0xAB581d4c),
        behavior: SnackBarBehavior.fixed,
        content: Text(msg, style: TextStyle(color: Colors.white))));
  }

  Widget setText(String text, double size, String fontFamily) {
    return Text(text, style: TextStyle(fontSize: size, fontFamily: fontFamily));
  }

  Future<void> showOkAlert(String msg, OkAlertCallback mAlertCallback) async {
    return showDialog<void>(
      context: mContext,
      barrierDismissible: false, // user must tap button!
      builder: (c) {
        return CupertinoAlertDialog(
          title: Text('BeautyBliss'),
          content: Text(msg),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(mContext).pop();
                mAlertCallback.onOk(mContext);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<Database> getDatabase() async {
    // Open the database and store the reference.
    String databasePath = join(await getDatabasesPath(), 'beautybliss.db');
    return openDatabase(databasePath, onCreate: _onCreate, version: 1);
  }

  static Future<void> _onCreate(Database dB, int version) async {
    await dB.execute("CREATE TABLE Bookings(id INTEGER PRIMARY KEY AUTOINCREMENT, brideName TEXT, eventType TEXT, receptionDateTime TEXT, receptionMonth TEXT, weddingDateTime TEXT, weddingMonth TEXT, otherEventDateTime TEXT, otherEventMonth TEXT, venue TEXT, packageCost INTEGER, advanceAmount INTEGER, hairStylist TEXT, description TEXT)");
  }

  static Future<int> insertValues(String tableName, Map<String, dynamic> tableMap) async {
    final Database db = await getDatabase();
    return await db.insert(tableName, tableMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getTableValues(String tableName, String selectedMonth) async {
    final Database db = await getDatabase();
    return await db.query(tableName, where: 'receptionMonth = ? OR weddingMonth = ? OR otherEventMonth = ?', whereArgs: [selectedMonth, selectedMonth, selectedMonth]);
  }

  static Future<List<Booking>> getListOfBookings(String selectedMonth) async {

    var bookingMap = await getTableValues('Bookings', selectedMonth);

    return List.generate(bookingMap.length, (index) {
      return Booking(brideName: bookingMap[index]['brideName'],
          eventType: bookingMap[index]['eventType'],

          receptionDateTime: bookingMap[index]['receptionDateTime'],
          receptionMonth: bookingMap[index]['receptionMonth'],
          weddingDateTime: bookingMap[index]['weddingDateTime'],
          weddingMonth: bookingMap[index]['weddingMonth'],

          otherEventDateTime: bookingMap[index]['otherEventDateTime'],
          otherEventMonth: bookingMap[index]['otherEventMonth'],

          venue: bookingMap[index]['venue'],
          packageCost: bookingMap[index]['packageCost'],
          advanceAmount: bookingMap[index]['advanceAmount'],
          hairStylist: bookingMap[index]['hairStylist'],
          description: bookingMap[index]['description']);
    });
  }

  void finish() {
    Navigator.pop(mContext);
  }

  void finishWithResult(dynamic result) {
    Navigator.pop(mContext, result);
  }
}


class OkAlertCallback {
  void onOk(BuildContext context) {
    print("BeautyBliss OK clicked");
  }
}