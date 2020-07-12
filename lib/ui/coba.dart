import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/share/drawer.dart';
import 'package:provider/provider.dart';

class Coba extends StatefulWidget {
  @override
  _CobaState createState() => _CobaState();
}

class _CobaState extends State<Coba> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
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
        body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('subscribe')
              .document(user.uid)
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.data['topics'].length,
              itemBuilder: (_, index) {
                print(snapshot.data.data['topics'].length);
                var kategori = snapshot.data.data['topics'][index];
                snapshot.data.data['topics'].length == 0
                    ? Text('data kosong')
                    : ListTile(
                      title: Text('kategori'),
                    );
              },
            );
          },
        ));
  }
}
