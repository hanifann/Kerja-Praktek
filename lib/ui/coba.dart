import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/share/carousel.dart';

class Coba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('coba'),
        ),
        // body: StreamBuilder<DocumentSnapshot>(
        //   stream:
        //       Firestore.instance.collection('ustadz').document('UAS').snapshots(),
        //   builder: (_, snapshot) {
        //     if (!snapshot.hasData) return CircularProgressIndicator();
        //     return ListView.builder(
        //       itemCount: snapshot.data.data['videoId'].length,
        //       itemBuilder: (_, index) {
        //         var videoId = YoutubePlayer.convertUrlToId(
        //             snapshot.data.data['videoId'][index]);
        //         return ListTile(
        //           title: Image.network('http://img.youtube.com/vi/$videoId/0.jpg'),
        //         );
        //       },
        //     );
        //   },
        // )
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Text('Menu',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
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
                            title: Text(
                                snapshot.data.documents[index].documentID,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11.0)),
                            onTap: () {
                              print(snapshot.data.documents[index].documentID
                                  .toString());
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
                            title: Text(
                                snapshot.data.documents[index].documentID,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11.0)),
                            onTap: () {},
                          );
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('ustadz').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (_, index) {
                print(snapshot.data.documents[index].documentID);
                print(snapshot.data.documents.length);
                return ListTile(
                  leading: Text(snapshot.data.documents[index].documentID),
                );
              },
            );
          },
        ));
  }
}
