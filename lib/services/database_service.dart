import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference subsCollection =
      Firestore.instance.collection('User');

  Future initiateData(String uid) async {
    return await subsCollection.document(uid).setData({}).then((value) {
      Firestore.instance
          .collection('User')
          .document(uid)
          .collection('ustadz')
          .document(uid)
          .setData({
            'ustadz': FieldValue.arrayUnion([]),
          });
      Firestore.instance
          .collection('User')
          .document(uid)
          .collection('topics')
          .document(uid)
          .setData({
            'topics': FieldValue.arrayUnion([]),
          });
    });
  }

  Future updateData(String data) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return Firestore.instance
        .collection('User')
          .document(firebaseUser.uid)
          .collection('ustadz')
          .document(firebaseUser.uid)
        .updateData({
      'ustadz': FieldValue.arrayUnion([data])
    }).then((_) {
      print('success');
    });
  }

  Future updateTopik(String data) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return Firestore.instance
        .collection('User')
        .document(firebaseUser.uid)
        .collection('topics')
        .document(firebaseUser.uid)
        .updateData({
      'topics': FieldValue.arrayUnion([data])
    }).then((_) {
      print('success');
    });
  }
}
