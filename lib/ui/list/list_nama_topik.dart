import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/services/database_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/list/list_video_ustadz_topik.dart';
import 'package:textfield_search/textfield_search.dart';

class ListNamaTopik extends StatefulWidget {
  @override
  _ListNamaTopikState createState() => _ListNamaTopikState();
}

class _ListNamaTopikState extends State<ListNamaTopik> {
  final TextEditingController controller = TextEditingController();

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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('nama').snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return Container(
                  padding: EdgeInsets.all(8.0),
                  height: 70.0,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        List<dynamic> listTopik =
                            snapshot.data.documents[index]['topics'];
                        return TextFieldSearch(
                          label: 'Cari Topik',
                          controller: controller,
                          initialList: listTopik,
                        );
                      }),
                );
              }),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ListvideoUstadzTopik(collection: 'topics',document: controller.text,field: 'videoId',))
                  );
              })
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('topics').snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(snapshot.data.documents[index].documentID),
                          trailing: RaisedButton(
                              child: Text('Favorite'),
                              textColor: textColor,
                              color: mainColor,
                              onPressed: () {
                                var ustadz =
                                    snapshot.data.documents[index].documentID;
                                setState(() {
                                  DatabaseService().updateTopik(ustadz);
                                });
                              }),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ListvideoUstadzTopik(
                                          collection: 'topics',
                                          document: snapshot
                                              .data.documents[index].documentID,
                                          field: 'videoId',
                                        )));
                          },
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
