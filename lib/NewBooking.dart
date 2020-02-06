import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:flutter/material.dart';

class NewBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => BeautyBlissUtils(mContext: context).finish()),
          title: Text("New Booking"),
          backgroundColor: Color(0xFF212121)),
    );
  }
}
