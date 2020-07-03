import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khutbah_center/share/color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> list = ['zakat', 'puasa', 'haji', 'aqiqah', 'pernikahan'];
  List<String> ust = [
    'Ust. Adi hidayat',
    'Ust. Abdul Somad',
    'Ust. Khalid Basalamah'
  ];
  List<String> vid = [
    'https://www.youtube.com/watch?v=hgUUZLKZA9w',
    'https://www.youtube.com/watch?v=E9osbVFFcVc',
    'https://www.youtube.com/watch?v=UO0r3cjAKcA',
    'https://www.youtube.com/watch?v=UO0r3cjAKcA'
  ];

  Widget vidTemplate(e) {
    var buid = YoutubePlayer.convertUrlToId(e);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/coba', arguments: {'id': buid});
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          child: Image.network(
            'http://img.youtube.com/vi/$buid/0.jpg',
            fit: BoxFit.cover,
            width: 150,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 350,
                padding: EdgeInsets.only(top: 45.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(
                            MediaQuery.of(context).size.width / 2, 50),
                        bottomRight: Radius.elliptical(
                            MediaQuery.of(context).size.width / 2, 50))),
                child: Column(
                  children: <Widget>[
                    Text('Khutbah Center',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 45.0,
                                color: Colors.white))),
                    Text(
                      'Pusat ceramah agama islam',
                      style: GoogleFonts.roboto(
                          textStyle:
                              TextStyle(fontSize: 25.0, color: Colors.white)),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Temukan dan dapatkan informasi ceramah terbaru \ndari ustadz favorit anda disini!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          textStyle:
                              TextStyle(fontSize: 16.0, color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 30),
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: secColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            contentPadding: EdgeInsets.all(10),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            hintText:
                                'masukan nama ustadz yang ingin anda cari'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                ),
                items: [
                  'https://www.youtube.com/watch?v=hgUUZLKZA9w',
                  'https://www.youtube.com/watch?v=E9osbVFFcVc',
                  'https://www.youtube.com/watch?v=UO0r3cjAKcA'
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      var id = YoutubePlayer.convertUrlToId('$i');
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/coba',
                              arguments: {'id': id});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          // decoration: BoxDecoration(
                          //   color: Colors.amber,
                          // ),
                          // child: YoutubePlayer(
                          //   controller: YoutubePlayerController(
                          //     initialVideoId: YoutubePlayer.convertUrlToId('$i'),
                          //     flags: YoutubePlayerFlags(
                          //       isLive: false,
                          //       loop: false,
                          //       forceHD: false,
                          //       mute: true,
                          //       autoPlay: false
                          //     )
                          //   ),
                          // )
                          child: Image.network(
                            'http://img.youtube.com/vi/$id/0.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                margin: EdgeInsets.only(top: 36.0),
                padding: EdgeInsets.symmetric(vertical: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: mainColor,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Ustadz yang ada Subsribe',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 18.0)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          vertical: BorderSide(width: 2.0, color: Colors.white),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[for (var item in ust) Text(item)],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 100.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                              children:
                                  vid.map((e) => vidTemplate(e)).toList()),
                        ],
                      ),
                    ),
                    SizedBox(height: 36.0),
                    Text(
                      'Topik yang ada Subsribe',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 18.0)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              vertical:
                                  BorderSide(width: 1.0, color: Colors.white))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[for (var item in list) Text(item)],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 100.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                              children:
                                  vid.map((e) => vidTemplate(e)).toList()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
