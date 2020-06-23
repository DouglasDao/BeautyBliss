import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:beautybliss/model/Booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import "package:intl/intl.dart";
import 'package:sqflite/sqflite.dart';

/**
 * Author: Douglas BR
 * Date: 23 Jun 2020
 */

class NewBooking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewBookingState();
  }
}

class NewBookingState extends State<NewBooking> {
  final _newBookingScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController brideNameController, eventTypeController, dateTimeController, receptionDateTimeController, weddingDateTimeController;
  TextEditingController venueController, packageCostController, advanceAmountController, hairStylistController, descController;
  GlobalKey<FormState> bookingFormKey;
  String eventType, receptionMonth, weddingMonth, otherEventMonth;
  bool isReceptionAndMuhurtham = false, dateTimeShow = false;
  FocusNode brideFocusNode = FocusNode();
  FocusNode eventTypeFocusNode = FocusNode();
  FocusNode dateTimeFocusNode = FocusNode();
  FocusNode receptionDateTimeFocusNode = FocusNode();
  FocusNode weddingDateTimeFocusNode = FocusNode();
  FocusNode venueFocusNode = FocusNode();
  FocusNode packageFocusNode = FocusNode();
  FocusNode advanceAmountFocusNode = FocusNode();
  FocusNode hairStylistFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  FocusNode submitFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    brideNameController = TextEditingController();
    eventTypeController = TextEditingController();
    dateTimeController = TextEditingController();
    receptionDateTimeController = TextEditingController();
    weddingDateTimeController = TextEditingController();
    venueController = TextEditingController();
    packageCostController = TextEditingController();
    advanceAmountController = TextEditingController();
    hairStylistController = TextEditingController();
    descController = TextEditingController();
    bookingFormKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _newBookingScaffoldKey,
        backgroundColor: Color(0xFF000000),

        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => BeautyBlissUtils(mContext: context).finishWithResult("")
            ),
            title: BeautyBlissUtils(mContext: context).setText("New Booking", 32.0, 'Lovers Quarrel'),
            backgroundColor: Color(0xAB581d4c)
        ),

        body: Form(
          key: bookingFormKey,

          child: Theme(
              data: ThemeData.dark().copyWith(
                  primaryColor: Color(0xAB581d4c),
                  accentColor: Colors.lightBlue),

              child: Padding(
                  padding: EdgeInsets.only(left: 14.0, top: 14.0, right: 14.0, bottom: 48.0),

                  child: ListView(
                    children: <Widget>[

                      // Bride Name
                      _setBasicTextFormFieldWidget(brideNameController, false, TextInputType.text, TextInputAction.next, 1, null, brideFocusNode, eventTypeFocusNode,
                          null, _setInputDecoration(true, Colors.black12, 'Bride name',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.person, color: Colors.grey))
                      ),

                      SizedBox(height: 8.0),

                      // Event Type
                      _setBasicTextFormFieldWidget(eventTypeController, true, TextInputType.text, TextInputAction.next, 1, null, eventTypeFocusNode, dateTimeFocusNode,
                          _onEventTypeTapped, _setInputDecoration(true, Colors.black12, 'Select Event',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.event, color: Colors.grey))
                      ),

                      if(dateTimeShow) SizedBox(height: 8.0),

                      // Non-Reception + Non-Muhurtham  Data & Time
                      if(dateTimeShow) Container(child: isReceptionAndMuhurtham ? null : _setBasicTextFormFieldWidget(dateTimeController,
                            true, TextInputType.datetime, null, 1, null, dateTimeFocusNode, venueFocusNode,
                            _onDateTimeTapped, _setInputDecoration(true, Colors.black12, 'Date & Time',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.date_range, color: Colors.grey)))
                        ),

                      // Reception Date & Time
                      if(dateTimeShow) Container(child: isReceptionAndMuhurtham ? _setBasicTextFormFieldWidget(receptionDateTimeController,
                            true, TextInputType.datetime, null, 1, null, null, null,
                            _onReceptionDateTimeTapped, _setInputDecoration(true, Colors.black12, 'Reception Date & Time',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.date_range, color: Colors.grey))) : null
                        ),

                      if(dateTimeShow && isReceptionAndMuhurtham) SizedBox(height: 8.0),

                      // Wedding Date & Time
                      if(dateTimeShow) Container(child: isReceptionAndMuhurtham ? _setBasicTextFormFieldWidget(weddingDateTimeController,
                            true, TextInputType.datetime, null, 1, null, weddingDateTimeFocusNode, venueFocusNode,
                            _onWeddingDateTimeTapped, _setInputDecoration(true, Colors.black12, 'Wedding Date & Time',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.date_range, color: Colors.grey))) : null
                        ),

                      SizedBox(height: 8.0),

                      // Venue
                      _setBasicTextFormFieldWidget(venueController, false, TextInputType.text, TextInputAction.next, 1, null, venueFocusNode, packageFocusNode,
                          null, _setInputDecoration(true, Colors.black12, 'Venue',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.place, color: Colors.grey))
                      ),

                      SizedBox(height: 8.0),

                      // Package Cost
                      _setBasicTextFormFieldWidget(packageCostController, false, TextInputType.phone, TextInputAction.next, 1, null, packageFocusNode, advanceAmountFocusNode,
                          null, _setInputDecoration(true, Colors.black12, 'Package Cost',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.monetization_on, color: Colors.grey))
                      ),

                      SizedBox(height: 8.0),

                      // Advance Amount
                      _setBasicTextFormFieldWidget(advanceAmountController, false, TextInputType.number, TextInputAction.next, 1, null, advanceAmountFocusNode, hairStylistFocusNode,
                          null, _setInputDecoration(true, Colors.black12, 'Advance Amount',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.monetization_on, color: Colors.grey))
                      ),

                      SizedBox(height: 8.0),

                      // Hair Stylist
                      _setBasicTextFormFieldWidget(hairStylistController, false, TextInputType.text, TextInputAction.next, 1, null, hairStylistFocusNode, descFocusNode,
                          null, _setInputDecoration(true, Colors.black12, 'Hair Stylist',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.album, color: Colors.grey))
                      ),

                      SizedBox(height: 8.0),

                      // Description
                      _setBasicTextFormFieldWidget(descController, false, TextInputType.multiline, TextInputAction.next, 2, null, descFocusNode, submitFocusNode,
                          null, _setInputDecoration(true, Colors.black12, 'Description',
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue, width: 0.8)),
                              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.8)), Icon(Icons.description, color: Colors.grey))
                      ),

                      SizedBox(height: 24.0),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CupertinoButton(
                            borderRadius: BorderRadius.circular(8.0), color: Color(0xAB581d4c), padding: EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 0.0),
                            onPressed: _onSubmitNewBookingForm, child: BeautyBlissUtils(mContext: context).setText('Submit', 18.0, 'Srisakdi'),
                          ),
                        ])
                    ],
                  )
              )
          ),
        ));
  }

  GestureTapCallback _onEventTypeTapped() {
    showCupertinoModalPopup(context: context, builder: (context) => getEventTypeCupertinoSheet(context));
  }

  GestureTapCallback _onDateTimeTapped() {
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDateTimePicker(context, onConfirm: (dateTime) {
      var dateFormat = DateFormat.yMMMd("en_US").add_jm().format(dateTime);
      dateTimeController.text = "$dateFormat";
      otherEventMonth = DateFormat.yMMMM().format(dateTime);
    });
  }


  GestureTapCallback _onReceptionDateTimeTapped() {
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDateTimePicker(context, onConfirm: (dateTime) {
      var dateFormat = DateFormat.yMMMd("en_US").add_jm().format(dateTime);
      receptionDateTimeController.text = "$dateFormat";
      receptionMonth = DateFormat.yMMMM().format(dateTime);
    });
  }


  GestureTapCallback _onWeddingDateTimeTapped() {
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDateTimePicker(context, onConfirm: (dateTime) {
      var dateFormat = DateFormat.yMMMd("en_US").add_jm().format(dateTime);
      weddingDateTimeController.text = "$dateFormat";
      weddingMonth = DateFormat.yMMMM().format(dateTime);
    });
  }

  Widget getEventTypeCupertinoSheet(BuildContext context) {
    return CupertinoActionSheet(
        actions: <Widget>[
          _setEventTypeCupertinoSheet(context, "Reception & Muhurtham", true),
          _setEventTypeCupertinoSheet(context, "Reception", false),
          _setEventTypeCupertinoSheet(context, "Muhurtham", false),
          _setEventTypeCupertinoSheet(context, "Engagement", false),
          _setEventTypeCupertinoSheet(context, "Baby Shower", false),
          _setEventTypeCupertinoSheet(context, "Pre/Post wedding", false),
          _setEventTypeCupertinoSheet(context, "Shoots", false),
        ]
    );
  }

  Widget _setEventTypeCupertinoSheet(BuildContext context, String actionSheetText,bool state) {

    return CupertinoActionSheetAction(child: Text(actionSheetText, style: TextStyle(color: Colors.blue, fontSize: 16, fontFamily: 'Srisakdi')),
        onPressed: () {
          dateTimeShow = true;
          eventTypeController.text = actionSheetText;
          setState(() {
            isReceptionAndMuhurtham = state;
            Navigator.pop(context);
          });
        });
  }

  void _onSubmitNewBookingForm() async {
    if (_isValidForm()) {

      String mReceptionDT = "", mReceptionMonth = "";
      String mWeddingDT = "", mWeddingMonth = "";
      String mDateTime = "", mMonth = "";

      if(isReceptionAndMuhurtham) {
          mReceptionDT = receptionDateTimeController.text;
          mReceptionMonth = receptionMonth;
          mWeddingDT = weddingDateTimeController.text;
          mWeddingMonth = weddingMonth;

      } else {
          mDateTime = dateTimeController.text;
          mMonth = otherEventMonth;
      }

      final booking = Booking(
          brideName: brideNameController.text,
          eventType: eventTypeController.text,

          receptionDateTime: mReceptionDT,
          receptionMonth: mReceptionMonth,
          weddingDateTime: mWeddingDT,
          weddingMonth: mWeddingMonth,

          otherEventDateTime: mDateTime,
          otherEventMonth: mMonth,

          venue: venueController.text,
          packageCost: int.parse(packageCostController.text),
          advanceAmount: int.parse(advanceAmountController.text),
          hairStylist: hairStylistController.text,
          description: descController.text);

      var insertState = await BeautyBlissUtils.insertValues('Bookings', booking.toMap());

      if (insertState != -1) {
          BeautyBlissUtils(mContext: context).showOkAlert("Bookings saved successfully!", AlertEvent());
      } else {
          BeautyBlissUtils(mContext: context).showOkAlert("Something went wrong. Please Try again!", null);
      }

      brideNameController.clear();
      eventTypeController.clear();
      dateTimeController.clear();
      receptionDateTimeController.clear();
      weddingDateTimeController.clear();
      bookingFormKey.currentState.reset();

      print(await listOfBookings());
    }
  }

  Future<List<Booking>> listOfBookings() async {
    // Get a reference to the database.
    final Database db = await BeautyBlissUtils.getDatabase();

    // Query the table for all The Booking.
    final List<Map<String, dynamic>> maps = await db.query('Bookings');

    // Convert the List<Map<String, dynamic> into a List<Booking>.
    return List.generate(maps.length, (i) {
      print(maps[i]['brideName']);

    });
  }

  bool _isValidForm() {

    if (brideNameController.text.isEmpty) {
      FocusScope.of(context).requestFocus(brideFocusNode);
      BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Bride Name is Mandatory!");
      return false;
    }

    if (eventTypeController.text.isEmpty) {
      FocusScope.of(context).requestFocus(eventTypeFocusNode);
      BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Event Type is Mandatory!");
      return false;
    }

    if (dateTimeShow) {
      if (isReceptionAndMuhurtham) {
        if (receptionDateTimeController.text.isEmpty) {
          FocusScope.of(context).requestFocus(receptionDateTimeFocusNode);
          BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Reception Date & Time is Mandatory!");
          return false;
        }
        if (weddingDateTimeController.text.isEmpty) {
          FocusScope.of(context).requestFocus(weddingDateTimeFocusNode);
          BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Wedding Date & Time is Mandatory!");
          return false;
        }
      }
      if (!isReceptionAndMuhurtham) {
        if (dateTimeController.text.isEmpty) {
          FocusScope.of(context).requestFocus(dateTimeFocusNode);
          BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Date & Time is Mandatory!");
          return false;
        }
      }
    }

    if (venueController.text.isEmpty) {
      FocusScope.of(context).requestFocus(venueFocusNode);
      BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Venue is Mandatory!");
      return false;
    }
    if (packageCostController.text.isEmpty) {
      FocusScope.of(context).requestFocus(packageFocusNode);
      BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Package-Cost is Mandatory!");
      return false;
    }
    if (advanceAmountController.text.isEmpty) {
      FocusScope.of(context).requestFocus(advanceAmountFocusNode);
      BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Advance Amount is Mandatory!");
      return false;
    }
    if (hairStylistController.text.isEmpty) {
      FocusScope.of(context).requestFocus(hairStylistFocusNode);
      BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Hair-Stylist is Mandatory!");
      return false;
    }
    if (descController.text.isEmpty) {
      FocusScope.of(context).requestFocus(descFocusNode);
      BeautyBlissUtils(mContext: context).showSnackBar(_newBookingScaffoldKey, "Description is Mandatory!");
      return false;
    }
    return true;
  }

  TextFormField _setBasicTextFormFieldWidget(TextEditingController textEditingController, bool isReadOnly, TextInputType inputType, TextInputAction inputAction,
      int textMaxLines, TextStyle textStyle, FocusNode currFocusNode, FocusNode nextFocusNode, GestureTapCallback onTapped, InputDecoration inputDecoration) {

    return TextFormField(controller: textEditingController, readOnly: isReadOnly, keyboardType: inputType, textInputAction: inputAction, maxLines: textMaxLines, style: TextStyle(fontFamily: 'Srisakdi'),
      focusNode: currFocusNode, onFieldSubmitted:(term){ _fieldFocusChange(context, currFocusNode, nextFocusNode);}, onTap: onTapped, decoration: inputDecoration);
  }

  InputDecoration _setInputDecoration(bool filled, Color fillColor, String labelText, InputBorder focusedBorder,
      InputBorder enabledBorder, Widget prefixIcon) {

    return InputDecoration(filled: filled, fillColor: fillColor, labelText: labelText, focusedBorder: focusedBorder, enabledBorder: enabledBorder,
        prefixIcon: prefixIcon);
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _disposeControllers();
    _disposeFocusNodes();
    super.dispose();
  }

  _disposeControllers() {
    brideNameController.dispose();
    eventTypeController.dispose();
    dateTimeController.dispose();
    receptionDateTimeController.dispose();
    weddingDateTimeController.dispose();
    venueController.dispose();
    packageCostController.dispose();
    advanceAmountController.dispose();
    hairStylistController.dispose();
    descController.dispose();
  }

  _disposeFocusNodes() {
    brideFocusNode.dispose();
    eventTypeFocusNode.dispose();
    receptionDateTimeFocusNode.dispose();
    weddingDateTimeFocusNode.dispose();
    venueFocusNode.dispose();
    packageFocusNode.dispose();
    advanceAmountFocusNode.dispose();
    hairStylistFocusNode.dispose();
    descFocusNode.dispose();
  }
}

class AlertEvent implements OkAlertCallback {
  @override
  void onOk(BuildContext context) {
    BeautyBlissUtils(mContext: context).finishWithResult("");
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
