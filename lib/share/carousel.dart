import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          Firestore.instance.collection('ustadz').document('abdul somad').snapshots(),
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
          items: <Widget>[
            ListView.builder(
                itemCount: snapshot.data.data['videoId'].length,
                itemBuilder: (_, index) {
                  var videoId = YoutubePlayer.convertUrlToId(
                      snapshot.data.data['videoId'][index]);
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network('http://img.youtube.com/vi/$videoId/0.jpg',
                    fit: BoxFit.cover,
                    height: 200,),
                  );
                }
              )
          ],
        );
      },
    );
  }
}
