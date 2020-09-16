import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenyaPayment/pages/detail.dart';
import '../models/order.dart';
import '../pages/detail.dart';

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

String getDateString(DateTime date) {
  try {
    return DateFormat('MM/dd').format(date);
  } catch (e) {
    return "";
  }
}
