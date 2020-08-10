import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/services/database_service.dart';
import 'package:khutbah_center/share/loading.dart';
import 'package:khutbah_center/ui/play_video.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:async/async.dart';

class ListUstadz extends StatefulWidget {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  @override
  _ListUstadzState createState() => _ListUstadzState();
}

class _ListUstadzState extends State<ListUstadz> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('User')
            .document(user.uid)
            .collection('ustadz')
            .document(user.uid)
            .snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data.data.isEmpty)
            return Center(
              child: Text(
                'Anda belum melakukan subscribe ke \n topik manapun',
                textAlign: TextAlign.center,
              ),
            );
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
                              child: FutureBuilder(
                                  future: widget._memoizer.runOnce(() => Future.wait([DatabaseService().getYoutubeMetadata(b, 'title'), DatabaseService().getYoutubeMetadata(b, 'durasi')])),
                                  builder: (context, text) {
                                    if (!text.hasData) return Loading();
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Video(
                                                        vid: convert(b),
                                                        docId: kategori,
                                                        collectionId: 'ustadz',
                                                      )));
                                        },
                                        leading: Container(
                                          height: 200.0,
                                          width: 100.0,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: Image.network(
                                              'http://img.youtube.com/vi/${convert(b)}/0.jpg',
                                              fit: BoxFit.cover,
                                              width: 150,
                                            ),
                                          ),
                                        ),
                                        title: Text(text.data[0] ?? "",
                                          style: TextStyle(
                                            fontSize: 12.0
                                          ),
                                        ),
                                        subtitle: Text(text.data[1] ?? ""),
                                      ),
                                    );
                                  }),
                            )
                        ],
                      );
                    }
                  );
              }
            );
        },
      ),
    );
  }
}
