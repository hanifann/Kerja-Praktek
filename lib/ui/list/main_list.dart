import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/list/list_nama_topik.dart';
import 'package:khutbah_center/ui/list/list_nama_ustadz.dart';

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Center(child: Text('Daftar Ustadz dan Topik')),
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
        body: ConnectivityWidgetWrapper(
          disableInteraction: true,
          child: TabBarView(
            children: [
              ListNamaUstadz(),
              ListNamaTopik(),
            ]
          ),
        )
      )
    );
  }
}
