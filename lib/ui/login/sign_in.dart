import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/login/sign_up.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _key = GlobalKey<FormState>();

  String error = '';
  String email = '';
  String password = '';
  bool loeading = false;

  Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
            Text('Sign In',
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Gordita',
                    fontWeight: FontWeight.w500)),
            Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 24.0),
                      child: TextFormField(
                        maxLines: 1,
                        autofocus: false,
                        validator: (val) =>
                            val.isEmpty ? 'Form ini tidak boleh kosong' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email,
                              color: Color.fromRGBO(89, 89, 90, 1)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color.fromRGBO(89, 89, 90, 1))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color.fromRGBO(89, 89, 90, 1)))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 24.0),
                      child: TextFormField(
                        validator: (val) => val.isEmpty ? 'form ini tidak boleh kosong' : null,
                        onChanged: (value) => password = value,
                        maxLines: 1,
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock,
                              color: Color.fromRGBO(89, 89, 90, 1)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color.fromRGBO(89, 89, 90, 1))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Color.fromRGBO(89, 89, 90, 1))),
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
                            TextSpan(text: 'Tidak punya akun? '),
                            TextSpan(
                              text: 'Daftar',
                              style: TextStyle(
                                color: Color.fromRGBO(138, 117, 219, 1)
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  Navigator.of(context).pushReplacement(_createRoute());
                                }
                            )
                          ]
                        )
                      ),
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
                        }
                      ),
                    )
                  ],
                )
              )
          ],
        ),
      ),
    );
  }
}
