import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference subsCollection =
      Firestore.instance.collection('subscribe');

  Future initiateData(String uid) async {
    return await subsCollection.document(uid).setData({
      'ustadz': FieldValue.arrayUnion([]),
      'topics': FieldValue.arrayUnion([])
    });
  }

  Future updateData(String data) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return Firestore.instance
        .collection('subscribe')
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
        .collection('subscribe')
        .document(firebaseUser.uid)
        .updateData({
      'topics': FieldValue.arrayUnion([data])
    }).then((_) {
      print('success');
    });
  }
}


