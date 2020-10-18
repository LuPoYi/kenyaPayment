import 'dart:math';

import 'package:flutter/material.dart';

import 'package:kenyaPayment/pages/detail.dart';
import '../models/order.dart';
import '../models/member.dart';
import '../pages/detail.dart';
import '../common/helper.dart';
import '../common/variable.dart';

Widget buildHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
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

Widget buildOrderCard(BuildContext context, Order order) {
  return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      //height: 120,
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blueAccent,
        elevation: 10,
        child: ListTile(
          leading: Icon(
            Icons.restaurant,
            size: 30,
          ),
          title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${order.title} - ${order.memo}",
                    style: TextStyle(color: Colors.white)),
                Text(getDateString(order.date),
                    style: TextStyle(color: Colors.white))
              ]),
          subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: ${order.total}',
                    style: TextStyle(color: Colors.white)),
                //Text('Me: -2000', style: TextStyle(color: Colors.white)),
                //Text(order.payers.length > 0 ? order.payers[0].name : "",
                //    style: TextStyle(color: Colors.white)),
                //Text(order.sharers.length > 0 ? order.sharers[0].name : "",
                //    style: TextStyle(color: Colors.white))
              ]),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.person),
            //Text(order.sharers.length.toString())
          ]),
          onTap: () => {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      content: Container(
                          width: 400,
                          height: 400,
                          child: Detail(order: order)));
                })
          },
        ),
      ));
}

Widget buildOrderCard2(BuildContext context, Order order) {
  bool isDebt = true;
  Random random = new Random();
  isDebt = random.nextInt(2) == 1;

  return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
      height: 250.0,
      width: 170.0,
      child: Card(
          color: isDebt ? debtColor : ownedColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          semanticContainer: true,
          elevation: 10,
          child: Container(
              padding: EdgeInsets.only(right: 16, bottom: 16),
              child: Column(children: [
                ListTile(
                  title: Text(
                    order.title,
                    style: TextStyle(fontSize: 14, color: Color(0xFF161616)),
                  ),
                  subtitle: Text(
                    getDateString(order.date),
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  onTap: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Container(
                                  width: 400,
                                  height: 400,
                                  child: Detail(order: order)));
                        })
                  },
                ),
                Container(
                    padding: EdgeInsets.only(left: 12),
                    width: 300,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 80.0,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: Text('+4', style: TextStyle(fontSize: 10)),
                          ),
                        ),
                        Positioned(
                          left: 60.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://ca.slack-edge.com/TGQCRQ19V-UHMLHRU4E-2a4d0cf648d1-512',
                            ),
                            radius: 12,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Positioned(
                          left: 40.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://ca.slack-edge.com/TGQCRQ19V-UGNPAS22D-0760d6e93d4e-512',
                            ),
                            radius: 12,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://ca.slack-edge.com/TGQCRQ19V-UKKT2L76J-e33e12091751-512',
                            ),
                            radius: 12,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://ca.slack-edge.com/TGQCRQ19V-UGNK3SF24-7fd0f15d7b10-512',
                          ),
                          radius: 12,
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    )),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 0.0),
                        child: Text(
                          "+ 1000",
                          style: TextStyle(fontSize: 28),
                        ) //Your widget here,
                        ),
                  ),
                )
              ]))));
}

Widget buildUserCard(BuildContext context, Member member) {
  print("Hi ${member.name}");
  return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blueAccent,
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(member.photoURL),
            radius: 24,
            backgroundColor: Colors.transparent,
          ),
          title: Text("${member.name}", style: TextStyle(color: Colors.black)),
          subtitle:
              Text("${member.email}", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.person),
          onTap: () => {},
        ),
      ));
}
