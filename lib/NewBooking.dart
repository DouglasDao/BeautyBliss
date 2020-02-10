import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import "package:intl/intl.dart";

class NewBooking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewBookingState();
  }
}

class NewBookingState extends State<NewBooking> {
  TextEditingController dateTimeTextEditController, eventTypeTextEditController,receptionDateTimeController,weddingDateTimeController;
  final _bookingFormKey = GlobalKey<FormState>();
  String eventType;
  bool receptionWeddingState = false;

  @override
  void initState() {
    dateTimeTextEditController = TextEditingController();
    eventTypeTextEditController = TextEditingController();
    receptionDateTimeController = TextEditingController();
    weddingDateTimeController = TextEditingController();
    dateTimeTextEditController.text = 'Date & Time ?';
    eventTypeTextEditController.text = 'Choose Event ?';
    receptionDateTimeController.text = 'Reception Date & Time ?';
    weddingDateTimeController.text = 'Wedding Date & Time ?';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF000000),

        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => BeautyBlissUtils(mContext: context).finish()),
            title: Text("New Booking"),
            backgroundColor: Color(0xAB581d4c)),

        body: Form(

          key: _bookingFormKey,

          child: Theme(

              data: ThemeData.dark().copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hintColor: Colors.grey,
                  primaryColor: Colors.grey,
                  accentColor: Colors.lightBlue),

              child: Padding(
                  padding: EdgeInsets.all(14.0),

                  child: ListView(
                    children: <Widget>[

                      // Bride Name
                      _setTextFormFieldWidget(null,null, Colors.grey, TextInputType.text, TextInputAction.next, TextStyle(color: Colors.white, fontSize: 16), null,
                          _setInputDecoration(true, Colors.white10, 'Bride name', 'Who is Bride ?',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              Icon(Icons.person, color: Colors.grey)), null),

                      SizedBox(height: 12.0),

                      // Event Type
                      _setTextFormFieldWidget(eventTypeTextEditController,AlwaysDisabledFocusNode(), Colors.grey, null, null, TextStyle(color: Colors.white, fontSize: 16), null,
                          _setInputDecoration(true, Colors.white10, 'Choose Event ?', eventTypeTextEditController.text,
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              Icon(Icons.event_seat, color: Colors.grey)), _onEventTypeTapped),

                      Container(child: receptionWeddingState ? null : SizedBox(height: 12.0)),

                      // Date & Time
                      Container(child: receptionWeddingState ? null : _setTextFormFieldWidget(dateTimeTextEditController,AlwaysDisabledFocusNode(), Colors.grey, null, null, null, null,
                              _setInputDecoration(true, Colors.white10, '', dateTimeTextEditController.text, null,
                                  UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                  Icon(Icons.date_range, color: Colors.grey)), _onDateTimeTapped)
                      ),

                      Container(child: receptionWeddingState ? SizedBox(height: 12.0) : null),

                      // Reception Date & Time
                      Container(child: receptionWeddingState ? _setTextFormFieldWidget(receptionDateTimeController,AlwaysDisabledFocusNode(), Colors.grey, null, null, null, null,
                            _setInputDecoration(true, Colors.white10, '', receptionDateTimeController.text, null,
                                UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                Icon(Icons.receipt, color: Colors.grey)), _onReceptionDateTimeTapped) : null
                      ),


                      Container(child: receptionWeddingState ? SizedBox(height: 12.0) : null),

                      // Wedding Date & Time
                      Container(
                        child: receptionWeddingState ? _setTextFormFieldWidget(weddingDateTimeController,AlwaysDisabledFocusNode(), Colors.grey, null, null, null, null,
                              _setInputDecoration(true, Colors.white10, '', weddingDateTimeController.text, null,
                                  UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                  Icon(Icons.event, color: Colors.grey)), _onWeddingDateTimeTapped)  : null
                      ),

                      SizedBox(height: 12.0),

                      // Venue
                      _setTextFormFieldWidget(null, null, Colors.grey, TextInputType.text, TextInputAction.next, TextStyle(color: Colors.white, fontSize: 16), null,
                          _setInputDecoration(true, Colors.white10, 'Venue', 'Where venue located ?',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                              Icon(Icons.location_on, color: Colors.grey)), null),

                    ],
                  ))),
        ));
  }

  GestureTapCallback _onEventTypeTapped() {
    showCupertinoModalPopup(context: context, builder: (context) => getCupertinoSheet(context));
  }



  GestureTapCallback _onDateTimeTapped() {
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDateTimePicker(context, onConfirm: (dateTime) {
      var dateFormat = DateFormat.yMMMd("en_US").add_jm().format(dateTime);
      dateTimeTextEditController.text = "$dateFormat";
    });
  }


  GestureTapCallback _onReceptionDateTimeTapped() {
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDateTimePicker(context, onConfirm: (dateTime) {
      var dateFormat = DateFormat.yMMMd("en_US").add_jm().format(dateTime);
      receptionDateTimeController.text = "$dateFormat";
    });
  }


  GestureTapCallback _onWeddingDateTimeTapped() {
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDateTimePicker(context, onConfirm: (dateTime) {
      var dateFormat = DateFormat.yMMMd("en_US").add_jm().format(dateTime);
      weddingDateTimeController.text = "$dateFormat";
    });
  }



  Widget _setCupertinoSheet(BuildContext context, String actionSheetText,bool state) {

    return CupertinoActionSheetAction(child: Text(actionSheetText, style: TextStyle(color: Colors.blue, fontSize: 16)),
        onPressed: () {
          eventTypeTextEditController.text = actionSheetText;
          setState(() {
            receptionWeddingState = state;
            Navigator.pop(context);
          });
        });
  }

  Widget getCupertinoSheet(BuildContext context) {
    return CupertinoActionSheet(
        actions: <Widget>[
          _setCupertinoSheet(context, "Reception & Muhurtham", true),
          _setCupertinoSheet(context, "Reception", false),
          _setCupertinoSheet(context, "Muhurtham", false),
          _setCupertinoSheet(context, "Engagement", false),
          _setCupertinoSheet(context, "Babyshower", false),
          _setCupertinoSheet(context, "Pre/Post wedding", false),
          _setCupertinoSheet(context, "Shoots", false),
        ]
    );
  }

  TextFormField _setTextFormFieldWidget(TextEditingController controller,FocusNode focusNode,Color cursorColor, TextInputType keyboardType, TextInputAction textInputAction,
      TextStyle style, int maxLength, InputDecoration decoration, GestureTapCallback onTap) {

    return TextFormField(cursorColor: cursorColor,focusNode: focusNode, keyboardType: keyboardType,
        textInputAction: textInputAction, style: style, maxLength: maxLength, decoration: decoration, onTap: onTap);
  }

  InputDecoration _setInputDecoration(bool filled, Color fillColor, String hintText, String labelText, InputBorder focusedBorder,
      InputBorder enabledBorder, Widget prefixIcon) {

    return InputDecoration(filled: filled, fillColor: fillColor, hintText: hintText, labelText: labelText, focusedBorder: focusedBorder,
        enabledBorder: enabledBorder, prefixIcon: prefixIcon);
  }

  @override
  void dispose() {
    dateTimeTextEditController.dispose();
    eventTypeTextEditController.dispose();
    super.dispose();
  }

  void _hasText(String text) {
    if (text.isEmpty) {
      SnackBar(content: Text("Field is mandatory!"));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
