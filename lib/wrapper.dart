import 'package:flutter/material.dart';
import 'package:khutbah_center/model/user_model.dart';
import 'package:khutbah_center/ui/bottom_navbar.dart';
import 'package:khutbah_center/ui/login/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return BottomNavbar();
    }
  }
}