import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kenyaPayment/models/order.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
import 'pages/settings.dart';
import 'package:kenyaPayment/services/firebase.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _totalController = new TextEditingController();
  TextEditingController _memoController = new TextEditingController();
  TextEditingController _kenyaController = new TextEditingController();
  TextEditingController _bobController = new TextEditingController();
  TextEditingController _shenController = new TextEditingController();

  DateTime selectedDate = DateTime.now();
  TextEditingController _datePickerController =
      TextEditingController(text: DateFormat('MM/dd').format(DateTime.now()));
  int _currentIndex = 0;
  PageController _pageController;

  final tabs = [
    HomePage(),
    ProfilePage(),
    SettingsPage(),
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
                BottomNavigationBarItem(icon: Icon(Icons.money), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: 'profile'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'settings'),
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
                  controller: _titleController,
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
                  controller: _totalController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    hintText: '總金額',
                    labelText: '總金額',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                padding: EdgeInsets.all(2.0),
                child: TextFormField(
                  controller: _memoController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    hintText: 'Memo',
                    labelText: '你可能會想填一下memo',
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

  Widget _secondFormPage(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Form(
            key: GlobalKey<FormState>(),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _kenyaController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    labelText: '克彥付多少',
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
                  controller: _bobController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    labelText: 'Bob',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _shenController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    labelText: 'Shen',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: RaisedButton(
                  child: Text("送出"),
                  onPressed: () {
                    //();

                    submitOrder();
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

  submitOrder() {
    //String title = "abc";
    //String memo = "memo";
    List<Payer> payers = List<Payer>();
    payers.add(Payer(name: "Kenya", price: int.parse(_kenyaController.text)));

    List<Sharer> sharers = List<Sharer>();
    sharers.add(Sharer(name: "Bob", price: int.parse(_bobController.text)));
    sharers.add(Sharer(name: "Shen", price: int.parse(_shenController.text)));

    Order order = Order(
        isFinish: false,
        memo: "這裡是memo",
        title: _titleController.text,
        total: int.parse(_totalController.text),
        payers: payers,
        sharers: sharers,
        date: selectedDate);

    FirebaseService.createOrder(order);

    //  clear form
    selectedDate = DateTime.now();
    _titleController.text = "";
    _totalController.text = "";
    _memoController.text = "";
    _kenyaController.text = "";
    _bobController.text = "";
    _shenController.text = "";
  }

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
