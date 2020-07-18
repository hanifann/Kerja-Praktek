import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/services/auth_service.dart';
import 'package:khutbah_center/share/carousel.dart';
import 'package:khutbah_center/share/chip.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/share/drawer.dart';
import 'package:khutbah_center/share/subsribe.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 230,
                padding: EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(
                            MediaQuery.of(context).size.width / 2, 50),
                        bottomRight: Radius.elliptical(
                            MediaQuery.of(context).size.width / 2, 50))),
                child: Column(
                  children: <Widget>[
                    Text('Khutbah Center',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 45.0,
                                color: textColor))),
                    Text(
                      'Pusat ceramah agama islam',
                      style: GoogleFonts.roboto(
                          textStyle:
                              TextStyle(fontSize: 25.0, color: textColor)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: secColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: textColor, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: textColor, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            contentPadding: EdgeInsets.all(10),
                            prefixIcon: Icon(
                              Icons.search,
                              color: textColor,
                            ),
                            hintText:
                                'masukan nama ustadz yang ingin anda cari'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Carousel(),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 36.0),
                padding: EdgeInsets.symmetric(vertical: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  color: mainColor,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Ustadz yang anda Subsribe',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        child: ChipSubsribe(
                          collectionName: 'ustadz',
                        )),
                    Container(
                        height: 100.0,
                        child: Subsribe(collection: 'ustadz',document: user.uid,field: 'ustadz',)),
                    SizedBox(height: 36.0),
                    Text(
                      'Topik yang anda Subsribe',
                      style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        child: ChipSubsribe(
                          collectionName: 'topics',
                        )),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 100.0,
                      child: Subsribe(collection: 'topics',document: user.uid,field: 'topics',),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
