import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/ui/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Subsribe extends StatelessWidget {
  final String document, collection;

  const Subsribe({this.document, this.collection});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection(collection)
          .document(document)
          .snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.data['videoId'].length,
            itemBuilder: (_, index) {
              var videoId = YoutubePlayer.convertUrlToId(
                  snapshot.data.data['videoId'][index]);
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Video(vid: videoId, docId: document, collectionId: collection,)));
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        'http://img.youtube.com/vi/$videoId/0.jpg',
                        fit: BoxFit.cover,
                        width: 150,
                      ),
                    )),
              );
            });
      },
    );
  }
}
