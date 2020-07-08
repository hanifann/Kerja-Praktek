import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Subsribe extends StatelessWidget {
  final String document;

  const Subsribe({this.document});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('ustadz')
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
            return Container(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  'http://img.youtube.com/vi/$videoId/0.jpg',
                  fit: BoxFit.cover,
                  width: 150,
                ),
              )
            );
          }
        );
      },
    );
  }
}
