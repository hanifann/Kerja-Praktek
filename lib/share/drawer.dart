import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/ui/list_video.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text("Ustadz"),
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('ustadz').snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(snapshot.data.documents[index].documentID,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 11.0)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ListVideo(
                                        collectionId: 'ustadz',
                                        documentId: snapshot
                                            .data.documents[index].documentID
                                            .toString(),
                                      )));
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Divider(),
          ExpansionTile(
            title: Text("Topik"),
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('topics').snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(snapshot.data.documents[index].documentID,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 11.0)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ListVideo(
                                        collectionId: 'topics',
                                        documentId: snapshot
                                            .data.documents[index].documentID
                                            .toString(),
                                      )));
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
