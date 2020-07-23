import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/services/database_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/list/list_video_ustadz_topik.dart';
import 'package:textfield_search/textfield_search.dart';

class ListNamaUstadz extends StatefulWidget {
  @override
  _ListNamaUstadzState createState() => _ListNamaUstadzState();
}

class _ListNamaUstadzState extends State<ListNamaUstadz> {
  TextEditingController controller = TextEditingController();
  bool _subscribe = false;

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
                        List<dynamic> listNama =
                            snapshot.data.documents[index]['nama'];
                        return TextFieldSearch(
                          label: 'Cari Nama Ustadz',
                          controller: controller,
                          initialList: listNama,
                        );
                      }),
                );
              }),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ListvideoUstadzTopik(collection: 'ustadz',document: controller.text,field: 'videoId',))
                  );
              })
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('ustadz').snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text('Ust. ' +
                              snapshot.data.documents[index].documentID),
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
                      }),
                );
              }),
        ],
      ),
    );
  }
}
