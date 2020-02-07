import 'package:beautybliss/BeautyBlissUtils.dart';
import 'package:flutter/material.dart';

class NewBooking extends StatelessWidget {

  final _bookingFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFF0A0E21),
            scaffoldBackgroundColor: Color(0xFF0A0E21),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.deepPurple),
              hintStyle: TextStyle(color: Colors.grey),
            )),
        home: Scaffold(

            appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () =>
                        BeautyBlissUtils(mContext: context).finish()),
                title: Text("New Booking"),
                backgroundColor: Color(0xFF212121)),

            body: Form(
                key: _bookingFormKey,
                child: Padding(

                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          cursorColor: Colors.deepPurple,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.deepPurple)
                            ),
                            contentPadding: EdgeInsets.all(8.0),
                            filled: true,
                            hintText: 'Bride name',
                            labelText: 'Who is Bride ?',
                          ),
                        )
                      ],
                    )
                )
            )
        )
    );
  }

  void _hasText(String text){
    if(text.isEmpty){
      SnackBar(content: Text("Field is mandatory!"));
    }
  }
}
