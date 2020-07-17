import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:khutbah_center/share/constraint.dart';
import 'package:khutbah_center/ui/home.dart';
import 'package:khutbah_center/ui/list/main_list.dart';
import 'package:khutbah_center/ui/subscribe/main_subscribe.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    MainList(),
    MainSubscribe()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: secColor,
            selectedItemBorderColor: Colors.white,
            unselectedItemIconColor: textColor,
            selectedItemBackgroundColor: mainColor,
            unselectedItemLabelColor: textColor 
          ),
          selectedIndex: _currentIndex,
          onSelectTab: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            FFNavigationBarItem(
                iconData: Icons.home, 
                label: 'Home'
              ),
            FFNavigationBarItem(
                iconData: Icons.reorder, 
                label: 'List'
              ),
            FFNavigationBarItem(
                iconData: Icons.favorite, 
                label: 'Favorite'
              ),
            FFNavigationBarItem(
                iconData: Icons.person, 
                label: 'Akun'
              ),
            
          ]),
    );
  }
}
