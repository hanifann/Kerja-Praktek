import 'package:flutter/material.dart';
import 'package:khutbah_center/share/color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  final String vid;
  Video({this.vid});
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  PlayerState _playerState;
  bool _isPlayerReady = false;
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
          forceHD: false,
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
    if (_isPlayerReady && mounted && !_controller.value.isControlsVisible) {
      _playerState = _controller.value.playerState;
      _videoMetaData = _controller.metadata;
    }
  }

  List<String> video = [
    'https://www.youtube.com/watch?v=rAdSmn-SOZU',
    'https://www.youtube.com/watch?v=_5aWGOoGY7w',
    'https://www.youtube.com/watch?v=XvvJkild0s4',
    'https://www.youtube.com/watch?v=4TWMMZ81tuQ',
    'https://www.youtube.com/watch?v=_SSV9CS9xWU',
    'https://www.youtube.com/watch?v=hgUUZLKZA9w',
    'https://www.youtube.com/watch?v=E9osbVFFcVc',
    'https://www.youtube.com/watch?v=UO0r3cjAKcA',
    'https://www.youtube.com/watch?v=hgUUZLKZA9w',
    'https://www.youtube.com/watch?v=E9osbVFFcVc',
    'https://www.youtube.com/watch?v=UO0r3cjAKcA'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Center(child: Text('Video')),
        ),
        body: Column(
          children: <Widget>[
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                  onReady: () {
                    _isPlayerReady = true;
                    print(_isPlayerReady.toString());
                  },
                  showVideoProgressIndicator: true,
                  controller: _controller),
              builder: (context, player) {
                return player;
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: video.length,
                  itemBuilder: (context, index) {
                    var buid = YoutubePlayer.convertUrlToId(video[index]);
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Video(vid: buid)));
                          },
                          leading: Container(
                              height: 150.0,
                              width: 100.0,
                              child: Image.network(
                                'http://img.youtube.com/vi/$buid/0.jpg',
                                fit: BoxFit.cover,
                              )),
                          title: Text('asdasdsa'),
                        ));
                  }),
            )
          ],
        ));
  }
}
