import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListNamaTopik extends StatelessWidget {
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
                  );
                }
              );
          }
        ),
    );
  }
}
