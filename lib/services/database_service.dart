import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
          .setData({});
      Firestore.instance
          .collection('User')
          .document(uid)
          .collection('topics')
          .document(uid)
          .setData({});
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

  Future deleteUstadz(String data) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return Firestore.instance
        .collection('User')
        .document(firebaseUser.uid)
        .collection('ustadz')
        .document(firebaseUser.uid)
        .setData({
      'ustadz': FieldValue.arrayRemove([data])
    });
  }

  Future getYoutubeMetadata(String link, String jenisData) async {
    var yt = YoutubeExplode();
    var videos = await yt.videos.get(link);

    switch (jenisData) {
      case 'title':
        return videos.title;
        break;
      case 'durasi':
        return videos.duration.toString().substring(0, 7);
      case 'deskripsi':
        return videos.description;
      default:
    }
    yt.close();
  }
}
