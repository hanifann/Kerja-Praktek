import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/services/auth_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:provider/provider.dart';

class ChipSubsribe extends StatefulWidget {
  final String collectionName, fieldName;
  ChipSubsribe({this.collectionName, this.fieldName});

  @override
  _ChipSubsribeState createState() => _ChipSubsribeState();
}

class _ChipSubsribeState extends State<ChipSubsribe> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection(widget.collectionName)
          .document(user.uid)
          .snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.data[widget.fieldName].length,
            itemBuilder: (_, index) {
              var kategori = snapshot.data.data[widget.fieldName][index];
              if (snapshot.data.data[widget.fieldName].length == 0) {
                return Text('Anda belum melakukan subscribe ');
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                      backgroundColor: secColor,
                      shadowColor: Colors.grey[200].withOpacity(.5),
                      label: Text(
                        kategori,
                        style: TextStyle(color: textColor),
                      )),
                );
              }
            });
      },
    );
  }
}
