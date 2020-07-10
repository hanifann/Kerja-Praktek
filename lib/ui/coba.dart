import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/share/drawer.dart';

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
        drawer: SideMenu(),
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
