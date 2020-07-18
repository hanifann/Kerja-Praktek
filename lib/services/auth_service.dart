import 'package:firebase_auth/firebase_auth.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/services/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userMail;

  //membuat user object sesuai dengan firebaseUser
  UserModel _userFromFireBase(FirebaseUser user) {
    return user != null ? UserModel(uid: user.uid, email: user.email) : null;
  }

  //membuat stream dari userModel
  Stream<UserModel> get user {
    return _auth.onAuthStateChanged.map(_userFromFireBase);
  }

  //membuat akun dengan email dan password
  //register with email and password
  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for user with uid
      await DatabaseService().initiateData(user.uid);
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCurrentUserEmail() async {
    final user =
        await _auth.currentUser().then((value) => userMail = value.email);
    return user;
  }

  //sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
