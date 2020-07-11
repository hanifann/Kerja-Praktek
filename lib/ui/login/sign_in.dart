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
              child: Text('Sign In',
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
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'form ini tidak boleh kosong' : null,
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
                      padding: const EdgeInsets.symmetric(vertical: 24.0,),
                      child: TextFormField(
                        validator: (val) => val.isEmpty ? 'form ini tidak boleh kosong' : null,
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
                                color: mainColor
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
                      buttonColor: mainColor,
                      child: RaisedButton(
                        textColor: Color.fromRGBO(88, 82, 78, 1),
                        child: Text('Sign In',
                        style: TextStyle(
                          fontFamily: 'Gordita'
                        ),),
                        onPressed: () {
                          if (_key.currentState.validate()) {
                            print('cek');
                          }
                        }
                      ),
                    )
                  ],
                )
                  ),
              )
            ],
          ),
        ),
        ],
      )
    );
  }
}
