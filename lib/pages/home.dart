import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      name = prefs.getString("name");
      email = prefs.getString("email");
      photoURL = prefs.getString("photoURL");
      isLogin = name != "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        name == "" ? Text("Null") : Text("Hi"),
        _buildHeader(context),
        _buildMainBody(context),
      ])),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/google_logo.png'),
            fit: BoxFit.contain,
            height: 70,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        photoURL,
                      ),
                      radius: 60,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      email,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// list all todo list
// current status
  Widget _buildMainBody(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List.generate(5, (idx) {
        return Card(
            child: Container(
                height: 30, width: 30, color: Colors.red, child: Text('$idx')));
      }),
    );
  }
}
