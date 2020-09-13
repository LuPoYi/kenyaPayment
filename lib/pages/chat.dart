import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/variable.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
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

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(roomsCollection)
          .doc("yJreT4x8Fr37dP6h55qq")
          .collection("messages")
          .orderBy("timestamp", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return messageTile(
                    snapshot.data.docs[index].data()["name"],
                    snapshot.data.docs[index].data()["message"],
                    snapshot.data.docs[index].data()["timestamp"],
                    snapshot.data.docs[index].data()["photoURL"],
                  );
                })
            : Container(child: Text("Nulllll"));
      },
    );
  }

  getChats() async {
    return FirebaseFirestore.instance
        .collection(roomsCollection)
        .doc("yJreT4x8Fr37dP6h55qq")
        .collection("messages")
        .snapshots();
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "name": name,
        "message": messageEditingController.text,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "photoURL": photoURL
      };

      FirebaseFirestore.instance
          .collection("rooms")
          .doc("yJreT4x8Fr37dP6h55qq")
          .collection("messages")
          .add(chatMessageMap)
          .catchError((e) {
        print(e.toString());
      });

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  Widget messageTile(userName, message, timestamp, photoURL) {
    bool sendByMe = userName == name;

    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          margin:
              sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: sendByMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23))
                  : BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
              gradient: LinearGradient(
                colors: sendByMe
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
              )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              sendByMe
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          photoURL,
                        ),
                        radius: 15,
                        backgroundColor: Colors.transparent,
                      )),
              Text(message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.redAccent,
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageEditingController,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                          hintText: "Message ...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(3),
                          child: Text("Send")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
