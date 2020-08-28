import 'package:flutter/material.dart';
import '../screens/HomePage.dart';
import '../screens/ChatPage.dart';
import '../screens/HistoryPage.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _pageIndex = 0;

  final tabs = [
    HomePage(),
    HistoryPage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Scaffold(
          backgroundColor: Color(0xFFf2f2fa),
          body: tabs[_pageIndex],
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
              currentIndex: 0,
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
              ],
              onTap: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
            )));
  }
}
