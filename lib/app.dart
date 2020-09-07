import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';
import 'pages/chat.dart';
import 'pages/history.dart';
import 'pages/profile.dart';

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
          floatingActionButton:
              _currentIndex == 0 ? _buildFloatingActionButton(context) : null,
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
                BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')
                    //label: 'Home',
                    ),
                BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('')
                    //label: 'History',
                    ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), title: Text('')
                    //label: 'Chat',
                    ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text('Profile')
                    //label: 'Profile',
                    ),
              ],
              onTap: onTabTapped,
            )));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return FloatingActionButton(
      heroTag: "lang",
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.category),
                                hintText: '餐廳/活動名稱',
                                labelText: '名稱',
                              ),
                              onSaved: (String value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String value) {
                                return value.contains('@')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.attach_money),
                                hintText: '全部付款金額',
                                labelText: '總金額',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.category),
                                labelText: '日期',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.category),
                                labelText: '付錢',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.category),
                                labelText: '平分',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: RaisedButton(
                              child: Text("Submit"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // if (_formKey.currentState.validate()) {
                                //   _formKey.currentState.save();
                                // }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
