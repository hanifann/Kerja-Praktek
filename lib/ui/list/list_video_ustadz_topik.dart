import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/play_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListvideoUstadzTopik extends StatelessWidget {
  final String collection, document, field;
  ListvideoUstadzTopik({this.document, this.collection, this.field});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Video'),
        backgroundColor: mainColor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
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
                itemCount: snapshot.data.data[field].length,
                itemBuilder: (_, index) {
                  var videoId = YoutubePlayer.convertUrlToId(
                      snapshot.data.data[field][index]);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Video(collectionId: collection, docId: document, vid: videoId,))
                        );
                      },
                      child: ListTile(
                        leading: Container(
                          width: 100,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(
                              'http://img.youtube.com/vi/$videoId/0.jpg',
                              fit: BoxFit.cover,
                              width: 150.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}