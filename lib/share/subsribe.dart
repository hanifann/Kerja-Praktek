import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/ui/play_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Subsribe extends StatelessWidget {
  final String document, collection, field;

  const Subsribe({this.document, this.collection, this.field});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('User')
          .document(document)
          .collection(collection)
          .document(document)
          .snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.data.data.isEmpty) return Center(child: Text('data kosong'));
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.data[field].length,
            itemBuilder: (_, index) {
              var kategori = snapshot.data.data[field][index];
              return StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection(collection)
                      .document(kategori)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    List<dynamic> list = snapshot.data.data['videoId'];
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            var videoId =
                                YoutubePlayer.convertUrlToId(list[index]);
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => Video(vid: videoId, docId: kategori, collectionId: collection,)));
                              },
                              child: Container(
                                  margin:
                                      EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.network(
                                      'http://img.youtube.com/vi/$videoId/0.jpg',
                                      fit: BoxFit.cover,
                                      width: 150,
                                    ),
                                  )
                                ),
                            );
                          }
                        ),
                    );
                  }
                );
            });
      },
    );
  }
}
