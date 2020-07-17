import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/services/auth_service.dart';
import 'package:khutbah_center/services/database_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/list_video.dart';
import 'package:khutbah_center/ui/subscribe/main_subscribe.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool _isSubsribe = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 64.0,
                  height: 64.0,
                  margin: EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/images/user.png'))),
                ),
                Text('john Doe'),
                SizedBox(
                  height: 4.0,
                ),
                Text(AuthService().getCurrentUserEmail().toString())
              ],
            ),
            decoration: BoxDecoration(color: mainColor),
          ),
          ExpansionTile(
            title: Text("Ustadz"),
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('ustadz').snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        trailing: RaisedButton(
                            color: _isSubsribe ? Colors.grey : mainColor,
                            child: Text('Subsribe'),
                            onPressed: () {
                              var ustadz =
                                  snapshot.data.documents[index].documentID;
                              setState(() {
                                DatabaseService().updateData(ustadz);
                              });
                            }),
                        title: Text(snapshot.data.documents[index].documentID,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 11.0)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ListVideo(
                                      collectionId: 'ustadz',
                                      documentId: snapshot
                                          .data.documents[index].documentID
                                          .toString())));
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Divider(),
          ExpansionTile(
            title: Text("Topik"),
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('topics').snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        trailing: RaisedButton(
                            color: mainColor,
                            child: Text('Subsribe'),
                            onPressed: () {
                              var topikData =
                                  snapshot.data.documents[index].documentID;
                              setState(() {
                                DatabaseService().updateTopik(topikData);
                              });
                            }),
                        title: Text(snapshot.data.documents[index].documentID,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 11.0)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ListVideo(
                                      collectionId: 'topics',
                                      documentId: snapshot
                                          .data.documents[index].documentID
                                          .toString())));
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Divider(),
          ListTile(
            title: Text('Subscribe'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MainSubscribe()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('Log Out'),
            onTap: () async {
              await AuthService().signOut();
            },
          )
        ],
      ),
    );
  }
}
