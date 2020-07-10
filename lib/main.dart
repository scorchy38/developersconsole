import 'dart:async';
import 'dart:io';

import 'package:chat_list/chat_list.dart';
import 'package:developersconsole/Screens/chat_screen.dart';
import 'package:developersconsole/Screens/new_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

//import 'package:intl/intl.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [Chat(), ChatScreen()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.settings),
          title: ("Settings"),
          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.systemGrey,
        ),
      ];
    }

    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);
    return MaterialApp(
      home: PersistentTabView(
        controller: _controller,
        items: _navBarsItems(),
        screens: _buildScreens(),
        showElevation: true,
        navBarCurve: NavBarCurve.upperCorners,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        iconSize: 26.0,
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property
        onItemSelected: (index) {
          print(index);
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
