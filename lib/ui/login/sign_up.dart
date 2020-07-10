import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/main.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/login/sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _key = GlobalKey<FormState>();

  String error = '';
  String email = '';
  String password = '';
  String password2 = '';
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sign Up',
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Gordita',
                    fontWeight: FontWeight.w500)),
            Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 24.0),
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: false,
                        validator: (val) =>
                            val.isEmpty ? 'Email tidak boleh kosong' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email,
                                color: Color.fromRGBO(89, 89, 90, 1)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(89, 89, 90, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(89, 89, 90, 1)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 24.0),
                      child: TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          if (val.length <= 6) {
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
                          prefixIcon: Icon(Icons.lock,
                              color: Color.fromRGBO(89, 89, 90, 1)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(89, 89, 90, 1))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(89, 89, 90, 1))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 24.0),
                      child: TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Password tidak boleh kosong';
                          } else if (val.length <= 6) {
                            return 'Password harus lebih dari 6 karakter';
                          } else if (val != password) {
                            return 'Konfirmasi password tidak sama dengan password';
                          }
                          return null;
                        },
                        onChanged: (value) => password2 = value,
                        maxLines: 1,
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Konfirmasi Password',
                          prefixIcon: Icon(Icons.lock_outline,
                              color: Color.fromRGBO(89, 89, 90, 1)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(89, 89, 90, 1))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(89, 89, 90, 1))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: textColor, fontFamily: 'Gordita'),
                              children: <TextSpan>[
                            TextSpan(text: 'Sudah punya akun? '),
                            TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                    color: Color.fromRGBO(138, 117, 219, 1)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushReplacement(_createRoute());
                                  })
                          ])),
                    ),
                    ButtonTheme(
                      minWidth: 130.0,
                      buttonColor: black,
                      child: RaisedButton(
                          textColor: Color.fromRGBO(237, 239, 244, 1),
                          child: Text('Sign In'),
                          onPressed: () {
                            if (_key.currentState.validate()) {
                              print('cek');
                            }
                          }),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
