import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/services/auth_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData(
          fontFamily: 'Gordita',
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: textColor, 
            displayColor: Colors.blue, 
          ),
        ),
      ),
    );
  }
}
