import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/share/drawer.dart';
import 'package:khutbah_center/share/subsribe.dart';
import 'package:khutbah_center/ui/play_video.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
              .collection('User')
              .document(user.uid)
              .collection('ustadz')
              .document(user.uid)
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data.data['ustadz'].length,
                itemBuilder: (_, index) {
                  // print(snapshot.data.data['topics'].length;
                  var kategori = snapshot.data.data['ustadz'][index];
                  return StreamBuilder<DocumentSnapshot>(
                      stream: Firestore.instance
                          .collection("ustadz")
                          .document(kategori)
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        List<dynamic> aaa = snapshot.data.data['videoId'];
                        String convert(String c) {
                          return YoutubePlayer.convertUrlToId(c);
                        }

                        return Column(
                          children: <Widget>[
                            for (var b in aaa)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => Video(vid: convert(b), docId: kategori, collectionId: 'ustadz',)));
                                },
                                leading: Container(
                                  height: 200.0,
                                  width: 100.0,
                                  child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                    child: Image.network(
                                      'http://img.youtube.com/vi/${convert(b)}/0.jpg',
                                        fit: BoxFit.cover,
                                        width: 150,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                });
          },
        ));
  }
}

// Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height,
//                           child: ListView.builder(
//                             itemCount: aaa.length,
//                             itemBuilder: (context, index) {
//                               var bbb = YoutubePlayer.convertUrlToId(aaa[index]);
//                               return InkWell(
//                                 onTap: () {
//                                   // Navigator.push(context,
//                                   //   MaterialPageRoute(builder: (_) => Video(vid: videoId, docId: document, collectionId: collection,)));
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(5.0),
//                                       child: Text(aaa.toString())
//                                     )),
//                                 );
//                               }),
//                         );
