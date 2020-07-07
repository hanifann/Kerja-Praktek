import 'package:flutter/material.dart';
import 'package:khutbah_center/share/color.dart';
import 'package:khutbah_center/ui/coba.dart';
import 'package:khutbah_center/ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: textColor, 
          displayColor: Colors.blue, 
        ),
      ),
      routes: {
        '/coba' : (context) => Coba()
      },
    );
  }
}
