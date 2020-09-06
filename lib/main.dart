import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'app.dart';
import 'pages/home.dart';

var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => LoginPage(),
  "/home": (BuildContext context) => HomePage(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Main',
    routes: routes,
    theme: ThemeData(
      primaryColor: Color(0xff145C9E),
      scaffoldBackgroundColor: Color(0xff1F1F1F),
      accentColor: Color(0xff007EF4),
      fontFamily: "OverpassRegular",
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin =
        prefs.getString("name") != null && prefs.getString("name") != "";

    if (isLogin) {
      Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => App()),
            (Route<dynamic> route) => false),
      );
    } else {
      Timer(Duration(seconds: 1),
          () => Navigator.pushReplacementNamed(context, "/auth"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text("Design Your splash screen"),
          ),
        ));
  }
}
