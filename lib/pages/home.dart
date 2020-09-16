import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../common/widget.dart';
import '../common/variable.dart';
import '../models/order.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLogin = false;
  String name = "";
  String email = "";
  String photoURL = "";
  List<Order> orders = new List();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString("name");
      email = prefs.getString("email");
      photoURL = prefs.getString("photoURL");
      isLogin = name != "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(children: [
        _buildHeader(context),
        _buildOverview(context),
        _buildOrderList(context),
      ])),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32, right: 32, bottom: 16),
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/google_logo.png'),
            fit: BoxFit.contain,
            height: 30,
          ),
        ],
      ),
    );
  }

// list all todo list
// current status
  Widget _buildOrderList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection(ordersCollection).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            //print("aaa: ${snapshot.data.docs}");
            List<Widget> orders = snapshot.data.docs.map((data) {
              return buildOrderCard(context, Order.fromSnapshot(data));
            }).toList();
            return Expanded(
                child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: orders,
            ));
          } else {
            return Container();
          }
        });
  }

  Widget _buildOverview(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        width: double.maxFinite,
        height: 120,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.pink,
            elevation: 10,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        photoURL,
                      ),
                      radius: 30,
                      backgroundColor: Colors.transparent,
                    ),
                    Text("-100",
                        style: TextStyle(fontSize: 24, color: Colors.white))
                  ],
                ))));
  }
}
