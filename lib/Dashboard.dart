
import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:beautybliss/BookingDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_strip/month_picker_strip.dart';

import 'model/Booking.dart';

/**
 * Author: Douglas BR
 * Date: 23 Jun 2020
 */

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardStateFul();
  }
}

class DashboardStateFul extends State<Dashboard> {

  int _tabPos = 0;
  String selectedMonth = DateFormat.yMMMM().format(DateTime.now());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color(0xFF000000),

        appBar: AppBar(
            leading: IconButton(
              icon: Icon(getAppBarIcon(_tabPos), color: Colors.lightBlue),
              onPressed: null,
            ),
            title: BeautyBlissUtils(mContext: context).setText(getAppBarTitle(_tabPos), 32.0, 'Lovers Quarrel'),
            backgroundColor: Color(0xAB581d4c)),

        body: _isDashOrBookingDetailsView(_tabPos),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF841d58),
          child: Icon(Icons.add, color: Colors.black),
          onPressed: () => startNewBooking(),
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

  Future startNewBooking() async {
    await BeautyBlissUtils(mContext: context).routeResultWidget("/NewBooking");
    setState(() {
      _dashboardLayout();
    });
  }

  Widget _dashboardLayout() {
    print("Selected Month : $selectedMonth");

    var bookingMap = BeautyBlissUtils.getListOfBookings(selectedMonth);

    return Container(
        child: Column(
            children: <Widget>[

              MonthStrip(
                normalTextStyle: TextStyle(color: Colors.white30, fontFamily: 'Srisakdi'),
                selectedTextStyle: TextStyle(color: Colors.white, fontFamily: 'Srisakdi'),
                format: 'MMM yyyy',
                from: DateTime(DateTime.now().year, DateTime.now().month),
                to: DateTime(2030, 12),
                initialMonth: DateTime(DateTime.now().year, DateTime.now().month),
                viewportFraction: 0.25,
                physics: PageScrollPhysics(),
                onMonthChanged: (dateTime) {
                  setState(() {
                    selectedMonth = DateFormat.yMMMM().format(dateTime);
                  });
                },
              ),

              Expanded(child: FutureBuilder<List<Booking>>(
                  future: bookingMap,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());

                    } else {
                      if (snapshot.hasData && snapshot.data.length > 0) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {

                            String brideName = snapshot.data[index].brideName;
                            String eventType = snapshot.data[index].eventType;
                            String receptionDateTime = snapshot.data[index].receptionDateTime;
                            String weddingDateTime = snapshot.data[index].weddingDateTime;
                            String otherEventDateTime = snapshot.data[index].otherEventDateTime;

                            return Card(
                              color: Colors.white10,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    leading: Icon(Icons.event, size: 35, color: Colors.grey),
                                    title: Padding(padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0), child: Text(brideName)),
                                    subtitle: eventType == "Reception & Muhurtham"
                                        ? Text(eventType + '\n' + receptionDateTime + " | " + weddingDateTime, textAlign: TextAlign.start, style: TextStyle(fontSize: 12.0))
                                        : Text(eventType + '\n' + otherEventDateTime, textAlign: TextAlign.start, style: TextStyle(fontSize: 12.0)),
                                    onTap: () {
                                      BeautyBlissUtils(mContext: context).materialRouteWidget(BookingDetails(), snapshot.data[index]);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: BeautyBlissUtils(mContext: context).setText("No Bookings Found!", 20.0, 'Srisakdi')
                        );
                      }
                    }
                  }
              )

              )
            ]
        )
    );
  }

  Widget _BookDetailsLayout(){
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
