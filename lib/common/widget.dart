import 'package:flutter/material.dart';

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

Widget buildOrderCard(dynamic order) {
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
                Text('印度咖理', style: TextStyle(color: Colors.white)),
                Text('09/06', style: TextStyle(color: Colors.white))
              ]),
          subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: 2000', style: TextStyle(color: Colors.white)),
                Text('Me: -2000', style: TextStyle(color: Colors.white))
              ]),
          trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.person), Text("3")]),
          onTap: () => {},
        ),
      ));
}
