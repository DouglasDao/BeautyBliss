import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewBooking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewBookingState();
  }
}

class NewBookingState extends State<NewBooking> {
  var _focusNode = FocusNode();

  final _bookingFormKey = GlobalKey<FormState>();

  @override
  void initState() {
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

                      TextFormField(
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                          maxLength: 64,
                          decoration: _setInputDecoration(true, Colors.white10, 'Bride name', 'Who is Bride ?',
                              UnderlineInputBorder(borderSide: BorderSide(
                                  color: Colors.lightBlue)),
                              UnderlineInputBorder(borderSide: BorderSide(
                                  color: Colors.transparent)),
                              Icon(Icons.person, color: Colors.grey))
                      ),

                      SizedBox(height: 12.0),

                      TextFormField(
                        cursorColor: Colors.grey,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white10,
                            labelText: 'Date ?',
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            prefixIcon: Icon(Icons.date_range, color: Colors.grey)
                        ),
                        onTap: () {
                          debugPrint("GestureDetector onTapped=============");
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DatePicker.showDatePicker(context);
                        },
                      ),

                    ],
                  )
              )
          ),
        ));
  }

  Widget _setTextFormFieldWidget(){

  }

  InputDecoration _setInputDecoration(bool filled, Color fillColor, String hintText,
      String labelText, InputBorder focusedBorder,InputBorder enabledBorder,Widget prefixIcon) {

    return InputDecoration(filled: filled, fillColor: fillColor, hintText: hintText, labelText: labelText,
        focusedBorder: focusedBorder, enabledBorder: enabledBorder, prefixIcon: prefixIcon);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(1970, 8),
        firstDate: new DateTime(1970, 8),
        lastDate: new DateTime(2101));
    if (picked != null && picked != new DateTime(1970, 8)) DateTime(1970, 8);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.unfocus();
  }

  void _hasText(String text) {
    if (text.isEmpty) {
      SnackBar(content: Text("Field is mandatory!"));
    }
  }
}
