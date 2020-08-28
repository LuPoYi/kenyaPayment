import 'package:flutter/material.dart';
import 'App/App.dart';
import 'LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    'App': (context) => App(),
    'Login Page': (context) => LoginPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Go',
        theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 222, 1.0),
        ),
        home: LoginPage(),
        routes: routes);
  }
}
