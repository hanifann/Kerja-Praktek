import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/services/database_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  final String vid, docId, collectionId;
  Video({this.vid, this.docId, this.collectionId});
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  // ignore: unused_field
  PlayerState _playerState;
  bool _isPlayerReady = false;
  // ignore: unused_field
  YoutubeMetaData _videoMetaData;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.vid,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          isLive: false,
          loop: false,
        ))
      ..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      _playerState = _controller.value.playerState;
      _videoMetaData = _controller.metadata;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Center(child: Text('play video')),
        ),
        body: Column(
          children: <Widget>[
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                  onReady: () => _isPlayerReady = true,
                  showVideoProgressIndicator: true,
                  controller: _controller),
              builder: (context, player) {
                return player;
              },
            ),
            Expanded(
                child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection(widget.collectionId)
                  .document(widget.docId)
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
                                            docId: widget.docId,
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
            ))
          ],
        ));
  }
}
