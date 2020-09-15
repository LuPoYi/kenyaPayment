import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kenyaPayment/common/variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/home.dart';
import 'pages/chat.dart';
import 'pages/history.dart';
import 'pages/profile.dart';
import 'models/order.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _datePickerController =
      TextEditingController(text: DateFormat('MM/dd').format(DateTime.now()));
  int _currentIndex = 0;
  PageController _pageController;

  final tabs = [
    HomePage(),
    HistoryPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text('')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), title: Text('')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), title: Text('')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text('Profile')),
              ],
              onTap: onTabTapped,
            )));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: "lang",
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildAlertDialogForm(context);
            });
      },
    );
  }

  Widget _buildAlertDialogForm(BuildContext context) {
    return AlertDialog(
        content: Container(
            width: 400,
            height: 400,
            child: PageView(
              controller: _pageController,
              children: [
                _firstFormPage(context),
                _secondFormPage(context),
                _thirdFormPage(context)
              ],
            )));
  }

  Widget _firstFormPage(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child: Form(
            key: GlobalKey<FormState>(),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    hintText: '餐廳/活動',
                    labelText: '餐廳/活動',
                  ),
                  onSaved: (String value) {},
                  validator: (String value) {
                    return value.contains('@')
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    hintText: '總金額',
                    labelText: '總金額',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _datePickerController,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100))
                        .then((date) {
                      setState(() {
                        _datePickerController.text =
                            DateFormat('MM/dd').format(date);
                      });
                    });
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    labelText: '日期',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: RaisedButton(
                  child: Text("Next1"),
                  onPressed: () {
                    pcNextPage();
                  },
                ),
              )
            ])));
  }

  Widget _secondFormPage(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Form(
            key: GlobalKey<FormState>(),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    labelText: '誰付的',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: RaisedButton(
                  child: Text("Next"),
                  onPressed: () {
                    pcNextPage();
                  },
                ),
              )
            ])));
  }

  Widget _thirdFormPage(BuildContext context) {
    return Container(
        color: Colors.deepPurple,
        child: Form(
            key: GlobalKey<FormState>(),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    labelText: 'For who?',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: RaisedButton(
                  child: Text("送出"),
                  onPressed: () {
                    //addOrder();
                    Navigator.of(context).pop();
                  },
                ),
              )
            ])));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void pcNextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  // addOrder() {
  //   String title = "abc";
  //   String memo = "memo";
  //   Order order = Order(title, memo: memo);

  //   FirebaseFirestore.instance
  //       .collection(ordersCollection)
  //       .add(order.toJson())
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // Widget _originFormPage(BuildContext context) {
  //   return Stack(
  //     overflow: Overflow.visible,
  //     children: <Widget>[
  //       Positioned(
  //         right: -40.0,
  //         top: -40.0,
  //         child: InkResponse(
  //           onTap: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: CircleAvatar(
  //             child: Icon(Icons.close),
  //             backgroundColor: Colors.red,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

}
