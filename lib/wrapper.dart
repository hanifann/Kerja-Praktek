import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/ui/coba.dart';
import 'package:khutbah_center/ui/home.dart';
import 'package:khutbah_center/ui/login/authenticate.dart';
import 'package:khutbah_center/ui/login/sign_in.dart';
import 'package:khutbah_center/ui/login/sign_up.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}