import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/services/database_service.dart';
import 'package:khutbah_center/share/constraint.dart';

class ListNamaTopik extends StatefulWidget {
  @override
  _ListNamaTopikState createState() => _ListNamaTopikState();
}

class _ListNamaTopikState extends State<ListNamaTopik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('topics').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(snapshot.data.documents[index].documentID),
                    trailing: RaisedButton(
                        child: Text('Favorite'),
                        textColor: textColor,
                        color: mainColor,
                        onPressed: () {
                          var ustadz =
                                  snapshot.data.documents[index].documentID;                               
                          setState(() {                            
                            DatabaseService().updateData(ustadz);
                          });
                        }),
                  );
                }
              );
          }
        ),
    );
  }
}
