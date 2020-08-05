import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/services/database_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/share/loading.dart';
import 'package:khutbah_center/ui/play_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:async/async.dart';

class ListvideoUstadzTopik extends StatefulWidget {
  final String collection, document, field;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  ListvideoUstadzTopik({this.document, this.collection, this.field});

  @override
  _ListvideoUstadzTopikState createState() => _ListvideoUstadzTopikState();
}

class _ListvideoUstadzTopikState extends State<ListvideoUstadzTopik> {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Video'),
        backgroundColor: mainColor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection(widget.collection)
              .document(widget.document)
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
                itemCount: snapshot.data.data[widget.field].length,
                itemBuilder: (_, index) {
                  var videoId = YoutubePlayer.convertUrlToId(
                      snapshot.data.data[widget.field][index]);
                  var link = snapshot.data.data[widget.field][index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Video(
                                      collectionId: widget.collection,
                                      docId: widget.document,
                                      vid: videoId,
                                    )));
                      },
                      child: FutureBuilder(
                          future: widget._memoizer.runOnce(() => Future.wait([DatabaseService().getYoutubeMetadata(link, 'durasi'), DatabaseService().getYoutubeMetadata(link, 'title')])),
                          builder: (context, text) {
                            if (!text.hasData) return Loading();
                            return Card(
                              child: ListTile(
                                leading: Container(
                                  width: 100,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Image.network(
                                      'http://img.youtube.com/vi/$videoId/0.jpg',
                                      fit: BoxFit.cover,
                                      width: 150.0,
                                    ),
                                  ),
                                ),
                                title: Text(text.data[1],
                                  style: TextStyle(
                                    fontSize: 12.0
                                  ),
                                ),
                                subtitle: Text(text.data[0]),
                              ),
                            );
                          }),
                    ),
                  );
                });
          }),
    );
  }
}
