import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Coba extends StatefulWidget {
  final String id;
  Coba({this.id});
  @override
  _CobaState createState() => _CobaState();
}

class _CobaState extends State<Coba> {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Coba')),
        ),
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
                initialVideoId: data['id'],
                flags: YoutubePlayerFlags(autoPlay: true, mute: false)),
          ),
          builder: (context, player) {
            return player;
          },
        ));
  }
}
