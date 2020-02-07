import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:flutter/material.dart';

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
    _focusNode.addListener(_focusListener);
  }

  void _focusListener(){
    if(_focusNode.hasFocus){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => BeautyBlissUtils(mContext: context).finish()),
            title: Text("New Booking"),
            backgroundColor: Color(0xFF212121)),

        body: Form(
          key: _bookingFormKey,
          child: Theme(

              data: ThemeData.dark().copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hintColor: Colors.grey,
                primaryColor: Colors.grey,
                accentColor: Colors.lightBlue
              ),

              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        focusNode: _focusNode,
                        autocorrect: false,
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Colors.white, fontSize: 16),

                        decoration: InputDecoration(

                            filled: true,
                            fillColor: Colors.white10,

                            hintText: 'Bride name',
                            labelText: 'Who is Bride ?',

                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue)),

                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent,
                                    style: BorderStyle.none)),

                            prefixIcon: Icon(Icons.person, color: Colors.grey)
                        ),
                      )
                    ],
                  )
              )

          ),
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_focusListener);
    _focusNode.unfocus();
  }

  void _hasText(String text) {
    if (text.isEmpty) {
      SnackBar(content: Text("Field is mandatory!"));
    }
  }
}
