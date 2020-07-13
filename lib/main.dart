import 'package:developersconsole/Screens/chat.dart';
import 'package:developersconsole/Screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/developers_list.dart';
import 'Screens/home_screen.dart';

void main() => runApp(NewApp());
getLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('status');
  return stringValue;
}

class NewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var status = getLoginStatus();
    return MaterialApp(
      theme: ThemeData(canvasColor: Colors.blue),
      home: status == 'LoggedIn' ? MainHome() : LoginScreen(),
    );
  }
}

class MainHome extends StatelessWidget {
  String userPhNo;
  MainHome({this.userPhNo});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [HomeScreen(), DevelopersList(userPhNo: userPhNo)];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: ("Home"),
          activeColor: Colors.white,
          inactiveColor: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.message),
          title: ("Chats"),
          activeColor: Colors.white,
          inactiveColor: Colors.white,
        ),
      ];
    }

    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);
    return MaterialApp(
      home: PersistentTabView(
        backgroundColor: Color(0xFF970101),
        controller: _controller,
        items: _navBarsItems(),
        screens: _buildScreens(),
        showElevation: true,
        navBarCurve: NavBarCurve.upperCorners,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        iconSize: 26.0,
        navBarStyle:
            NavBarStyle.style9, // Choose the nav bar style with this property
        onItemSelected: (index) {
          print(index);
        },
      ),
    );
  }
}
