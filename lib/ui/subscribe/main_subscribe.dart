import 'package:flutter/material.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/subscribe/list_topik.dart';
import 'package:khutbah_center/ui/subscribe/list_ustadz.dart';
class MainSubscribe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text('subscribe'),
          bottom: TabBar(
            indicatorColor: secColor,
            tabs: [
              Text(
                'Ustadz'
              ),
              Text(
                'Topik'
              )
            ]
          ),
        ),
        body: TabBarView(
          children: [
            ListUstadz(),
            ListTopik()
          ]
        )
      )
    );
  }
}