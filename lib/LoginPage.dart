import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('App');
        },
        padding: EdgeInsets.all(24),
        color: Colors.white,
        child: Text("Login", style: TextStyle(color: Colors.deepOrange)),
      ),
    );

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          color: new Color(0xff622F74),
          gradient: LinearGradient(
            colors: [new Color(0xff29dfb7), new Color(0xff3ec7fd)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          )),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 48.0, right: 48.0),
          children: <Widget>[loginButton],
        ),
      ),
    ));
  }
}
