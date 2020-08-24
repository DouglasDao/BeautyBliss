import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BeautyBlissUtils.dart';
import 'model/Booking.dart';

/**
 * Author: Douglas BR
 * Date: 23 Jun 2020
 */

class BookingDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Booking booking = ModalRoute.of(context).settings.arguments;
    var bookingDetailsList = LinkedHashMap<String, String>();
    var bookingDetailsMap = Map<String, String>();

    bookingDetailsMap['Bride Name'] = booking.brideName;
    bookingDetailsMap['Event Type'] = booking.eventType;

    if (booking.eventType == "Reception & Muhurtham") {
      bookingDetailsMap['Reception Date & Time'] = booking.receptionDateTime;
      bookingDetailsMap['Wedding Date & Time'] = booking.weddingDateTime;
    } else {
      bookingDetailsMap['Date & Time'] = booking.otherEventDateTime;
    }

    bookingDetailsMap['Venue'] = booking.venue;
    bookingDetailsMap['Package Cost'] = booking.packageCost.toString();
    bookingDetailsMap['Advance Amount'] = booking.advanceAmount.toString();
    bookingDetailsMap['Hair Stylist'] = booking.hairStylist;
    bookingDetailsMap['Description'] = booking.description;

    bookingDetailsList.addAll(bookingDetailsMap);

    return Scaffold(

        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => BeautyBlissUtils(mContext: context).finish()),
            title: BeautyBlissUtils(mContext: context).setText("Booking Details", 32.0, 'Lovers Quarrel'),
            backgroundColor: Color(0xAB581d4c)),

        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.separated(
              itemCount: bookingDetailsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                        leading: BeautyBlissUtils(mContext: context).setText(bookingDetailsList.keys.elementAt(index), 14.0, 'Srisakdi'),
                        trailing: BeautyBlissUtils(mContext: context).setText(bookingDetailsList.values.elementAt(index), 14.0, 'Srisakdi')
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0, thickness: 0.4, color: Colors.grey)
            )
        )
    );
  }
}
