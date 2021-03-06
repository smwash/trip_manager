import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trip_manager/constants.dart';
import 'package:trip_manager/screens/addtripscreen.dart';
import 'package:trip_manager/screens/favsscreen.dart';
import 'package:trip_manager/screens/homescreen.dart';
import 'package:trip_manager/screens/profilepage.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> _screens = [
    HomePage(),
    FavsScreen(),
    ProfilePage(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        child: BottomNavigationBar(
          iconSize: 30.0,
          selectedItemColor: kAccentColor.withOpacity(0.7),
          unselectedItemColor: kBlackColor,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.folderHome),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountHeart),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountCog),
              title: SizedBox.shrink(),
            ),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAccentColor,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTripScreen(),
            ),
          );
        },
      ),
    );
  }
}
