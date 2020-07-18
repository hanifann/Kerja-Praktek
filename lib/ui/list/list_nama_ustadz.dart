import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/services/database_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/list/list_video_ustadz_topik.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListNamaUstadz extends StatefulWidget {
  @override
  _ListNamaUstadzState createState() => _ListNamaUstadzState();
}

class _ListNamaUstadzState extends State<ListNamaUstadz> {
  bool _subscribe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('ustadz').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                        'Ust. ' + snapshot.data.documents[index].documentID),
                    trailing: RaisedButton(
                        child: Text('Favorite'),
                        textColor: textColor,
                        color: _subscribe ? Colors.grey : mainColor,
                        onPressed: () {
                          var ustadz =
                              snapshot.data.documents[index].documentID;
                          setState(() {
                            DatabaseService().updateData(ustadz);
                          });
                        }),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ListvideoUstadzTopik(
                                    collection: 'ustadz',
                                    document: snapshot
                                        .data.documents[index].documentID,
                                    field: 'videoId',
                                  )));
                    },
                  );
                });
          }),
    );
  }
}
