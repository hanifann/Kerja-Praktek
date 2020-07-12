import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/ui/play_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListVideo extends StatefulWidget {
  final String documentId, collectionId;

  const ListVideo({this.documentId, this.collectionId});

  @override
  _ListVideoState createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection(widget.collectionId)
            .document(widget.documentId)
            .snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());          
          return ListView.builder(
              itemCount: snapshot.data.data['videoId'].length,
              itemBuilder: (_, index) {
                var videoId = YoutubePlayer.convertUrlToId(
                    snapshot.data.data['videoId'][index]);
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Video(
                                      vid: videoId,
                                      // docId: widget.documentId,
                                      collectionId: widget.collectionId,
                                    )));
                      },
                      leading: Container(
                          height: 200.0,
                          width: 100.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                              'http://img.youtube.com/vi/$videoId/0.jpg',
                              fit: BoxFit.cover,
                            ),
                          )),
                    ));
              });
        },
      ),
    );
  }
}
