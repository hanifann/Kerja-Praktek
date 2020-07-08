import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/share/color.dart';

class ChipSubsribe extends StatelessWidget {
  final String collectionName;
  ChipSubsribe({this.collectionName});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(collectionName).snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (_, index) {
              var kategori =
                  snapshot.data.documents[index].documentID.toString();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                    backgroundColor: secColor,
                    shadowColor: Colors.grey[200].withOpacity(.5),
                    label: Text(
                      kategori,
                      style: TextStyle(color: textColor),
                    )
                  ),
              );
            }
          );
      },
    );
  }
}
