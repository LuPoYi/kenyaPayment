import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenyaPayment/services/firebase.dart';
import '../models/member.dart';
import '../common/widget.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLogin = false;
  String name = "";
  String email = "";
  String photoURL = "";

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isLogin = prefs.getBool("isLogin");
      name = prefs.getString("name");
      email = prefs.getString("email");
      photoURL = prefs.getString("photoURL");
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget memeberWidgetList = StreamBuilder<QuerySnapshot>(
        stream: FirebaseService.getMembersSnapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            print("snapshot.data.docs $snapshot.data.docs");

            return Column(
                children: snapshot.data.docs.map((data) {
              return buildUserCard(context, Member.fromSnapshot(data));
            }).toList());
          } else {
            return Container();
          }
        });

    return Column(
      children: [
        Text("email: $email"),
        Text("name: $name"),
        memeberWidgetList,
        FlatButton(
          onPressed: () {
            _signOutGoogle();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false);
          },
          child: Text(
            'Sign Out',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF6f8ee4),
            ),
          ),
        ),
        Text("這邊可以放一些統計資料，i.e. 克彥總付款20000"),
      ],
    );
  }

  void _signOutGoogle() async {
    print("User Sign Out start");
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    print("User Sign Out end");
  }
}
