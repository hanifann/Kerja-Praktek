import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/ui/play_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('ustadz')
          .document('abdul somad')
          .snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enlargeCenterPage: true,
            ),
            items: snapshot.data.data['videoId'].map<Widget>((e) {
              var videoId = YoutubePlayer.convertUrlToId(e);
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => Video(collectionId: 'ustadz',docId: 'abdul somad',vid: videoId))
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    'http://img.youtube.com/vi/$videoId/0.jpg',
                    fit: BoxFit.cover,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              );
            }).toList()
        );
      },
    );
  }
}

