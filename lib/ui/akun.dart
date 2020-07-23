import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/services/auth_service.dart';
import 'package:provider/provider.dart';

class Akun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(user.email),
          RaisedButton(
            onPressed: () async {
              await AuthService().signOut();
            },
            child: Text('Log Out'),
          )
        ],
      ),
    ));
  }
}
