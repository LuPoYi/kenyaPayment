import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/chat.dart';
import 'pages/history.dart';
import 'pages/profile.dart';
import 'pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final tabs = [
    HomePage(),
    HistoryPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Scaffold(
          backgroundColor: Color(0xFFf2f2fa),
          body: tabs[_currentIndex],
          bottomNavigationBar: _buildBottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Color(0xFFF2F2FA),
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              currentIndex: _currentIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Color(0xFF5579DB),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onTap: onTabTapped,
            )));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
