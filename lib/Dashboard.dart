import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NewBooking.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardStateFul();
  }
}

class DashboardStateFul extends State<Dashboard> {

  int _tabPos = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF000000),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(getAppBarIcon(_tabPos), color: Colors.lightBlue), onPressed: null,
          ),
          title: Text(getAppBarTitle(_tabPos)),
            backgroundColor: Color(0xAB581d4c)
      ),

      body: _isDashOrBookingDetailsView(_tabPos),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF841d58),
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () {
            BeautyBlissUtils(mContext: context).startWidget(NewBooking());
          },
          elevation: 24.0,
      ),

      bottomNavigationBar: BottomAppBar(

        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.dashboard),
              padding: EdgeInsets.fromLTRB(32.0, 0, 32.0, 0),
              color: _setColorForDashboard(_tabPos),
              onPressed: () => _itemTapped(0)
            ),
            IconButton(
              icon: Icon(Icons.details),
              padding: EdgeInsets.fromLTRB(32.0, 0, 32.0, 0),
              color: _setColorForBookingDetails(_tabPos),
              onPressed: () => _itemTapped(1)
            ),
          ],
        )
      )
    );
  }

  Widget _dashboardLayout() {
    return Scaffold(

    );
  }

  void _itemTapped(int pos) {
    setState(() {
      this._tabPos = pos;
    });
  }

  MaterialColor _setColorForDashboard(int pos) {
    return pos == 0 ? Colors.lightBlue : Colors.grey;
  }

  MaterialColor _setColorForBookingDetails(int pos) {
    return pos == 1 ? Colors.lightBlue : Colors.grey;
  }

  Widget _BookDetailsLayout(){
  }

  String getAppBarTitle(int index){
    return index == 0 ? 'Dashboard' : 'Booking Details';
  }

  IconData getAppBarIcon(int index){
    return index == 0 ? Icons.dashboard : Icons.details;
  }

  Widget _isDashOrBookingDetailsView(int tabPos) {
    if (tabPos == 0) {
      return _dashboardLayout();
    } else if (tabPos == 1) {
      return Container(
        child: Text('Booking Details'),
      );
    }
    return _dashboardLayout();
  }
}
