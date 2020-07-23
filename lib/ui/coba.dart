import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/ui/list/list_video_ustadz_topik.dart';
import 'package:provider/provider.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Coba extends StatefulWidget {
  @override
  _CobaState createState() => _CobaState();
}

class _CobaState extends State<Coba> {
  TextEditingController controller = TextEditingController();
  String label = "Some Label";
  List<String> dummyList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  String fetchData() {
    Firestore.instance.collection('ustadz').document().documentID;
    List _list = new List();
    String _inputText = controller.text;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_printValue());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _printValue() {
    print(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('coba'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('nama').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (_, index) {
                  // print(snapshot.data.data['topics'].length;
                  String convert(String c) {
                    return YoutubePlayer.convertUrlToId(c);
                  }

                  List<dynamic> aaa = snapshot.data.documents[index]['nama'];
                  return Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: TextFieldSearch(
                            label: 'Cari nama ustadz',
                            controller: controller,
                            initialList: aaa,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red,
                          child: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ListvideoUstadzTopik(
                                              collection: 'ustadz',
                                              document: controller.text,
                                              field: 'videoId',
                                            )));
                              }),
                        ),
                      ],
                    ),
                  );
                });
          },
        ));
    // body: Column(
    //   children: <Widget>[
    //     TextFieldSearch(
    //         initialList: dummyList, label: label, controller: controller),
    //   ],
    // ));
  }
}

// Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.height,
//                           child: ListView.builder(
//                             itemCount: aaa.length,
//                             itemBuilder: (context, index) {
//                               var bbb = YoutubePlayer.convertUrlToId(aaa[index]);
//                               return InkWell(
//                                 onTap: () {
//                                   // Navigator.push(context,
//                                   //   MaterialPageRoute(builder: (_) => Video(vid: videoId, docId: document, collectionId: collection,)));
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(5.0),
//                                       child: Text(aaa.toString())
//                                     )),
//                                 );
//                               }),
//                         );
