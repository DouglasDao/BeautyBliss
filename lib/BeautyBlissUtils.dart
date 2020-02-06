


import 'package:flutter/material.dart';

class BeautyBlissUtils {

  BuildContext mContext;

  BeautyBlissUtils({this.mContext});

  void startWidget(Widget screen){
    Navigator.push(mContext, MaterialPageRoute(builder: (mContext) => screen));
  }
}