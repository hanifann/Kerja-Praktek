import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/services/auth_service.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/share/loading.dart';
import 'package:khutbah_center/ui/login/sign_in.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _key = GlobalKey<FormState>();
  AuthService _auth = AuthService();

  String error = '';
  String email = '';
  String password = '';
  bool loeading = false;

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignIn(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loeading
        ? Loading()
        : Scaffold(
            backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            body: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: mainColor,
                  ),
                  child: Center(
                    child: Text('Sign Up',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'Gordita',
                        )),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 30,
                    decoration: BoxDecoration(
                      color: secColor,
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 50,
                    decoration: BoxDecoration(
                      color: mainColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 24.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Form(
                            key: _key,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  validator: (val) => val.isEmpty
                                      ? 'Email tidak boleh kosong'
                                      : null,
                                  onChanged: (value) => email = value,
                                  maxLines: 1,
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    filled: true,
                                    fillColor: secColor,
                                    prefixIcon: Icon(Icons.email,
                                        color: Color.fromRGBO(89, 89, 90, 1)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24.0,
                                  ),
                                  child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Password tidak boleh kosong';
                                      }
                                      if (val.length < 6) {
                                        return 'Password harus lebih dari 6 karakter';
                                      }
                                      if (val.contains(RegExp(r'[A-Z]'), 1)) {
                                        return 'Password harus memiliki satu huruf kapital';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) => password = value,
                                    maxLines: 1,
                                    obscureText: true,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      filled: true,
                                      fillColor: secColor,
                                      prefixIcon: Icon(Icons.lock,
                                          color: Color.fromRGBO(89, 89, 90, 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Password tidak boleh kosong';
                                      } else if (val.length < 6) {
                                        return 'Password harus lebih dari 6 karakter';
                                      } else if (val != password) {
                                        return 'Konfirmasi password tidak sama dengan password';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) => password = value,
                                    maxLines: 1,
                                    obscureText: true,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: 'Konfirmasi Password',
                                      filled: true,
                                      fillColor: secColor,
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: Color.fromRGBO(89, 89, 90, 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: textColor,
                                              fontFamily: 'Gordita'),
                                          children: <TextSpan>[
                                        TextSpan(text: 'Sudah punya akun? '),
                                        TextSpan(
                                            text: 'Login',
                                            style: TextStyle(color: mainColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                widget.toggleView();
                                              })
                                      ])),
                                ),
                                ButtonTheme(
                                  minWidth: 130.0,
                                  buttonColor: mainColor,
                                  child: RaisedButton(
                                      textColor: Color.fromRGBO(88, 82, 78, 1),
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(fontFamily: 'Gordita'),
                                      ),
                                      onPressed: () async {
                                        if (_key.currentState.validate()) {
                                            setState(() => loeading = true);
                                            dynamic result = await _auth
                                                .register(email, password);
                                            if (result == null) {
                                              setState(() {
                                                error =
                                                    'data yang anda masukan tidak valid';
                                                loeading = false;
                                              });
                                            }
                                          }
                                        }),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ));
  }
}
