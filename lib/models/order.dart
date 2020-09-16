// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order(
      {this.payers,
      this.memo,
      this.title,
      this.isFinish,
      this.date,
      this.total,
      this.sharers,
      this.reference});

  List<Payer> payers;
  String memo;
  String title;
  bool isFinish = false;
  DateTime date;
  int total;
  List<Sharer> sharers;
  DocumentReference reference;

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    Order newOrder = Order.fromJson(snapshot.data());
    newOrder.reference = snapshot.reference;
    return newOrder;
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        payers: List<Payer>.from(json["payers"].map((x) => Payer.fromJson(x))),
        memo: json["memo"],
        title: json["title"],
        isFinish: json["isFinish"],
        //date: json["date"],
        date:
            json['date'] == null ? null : (json['date'] as Timestamp).toDate(),
        total: json["total"],
        sharers:
            List<Sharer>.from(json["sharers"].map((x) => Sharer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payers": List<dynamic>.from(payers.map((x) => x.toJson())),
        "memo": memo,
        "title": title,
        "isFinish": isFinish,
        "date": date,
        "total": total,
        "sharers": List<dynamic>.from(sharers.map((x) => x.toJson())),
      };
}

class Payer {
  Payer({
    this.name,
    this.price,
  });

  String name;
  int price;

  factory Payer.fromJson(Map<String, dynamic> json) => Payer(
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}

class Sharer {
  Sharer({
    this.flag,
    this.name,
    this.price,
  });

  int flag = 0;
  String name;
  int price;

  factory Sharer.fromJson(Map<String, dynamic> json) => Sharer(
        flag: json["flag"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "name": name,
        "price": price,
      };
}

/* 
{"payers": [{"name": "PoYi", "price": 200}], "memo": "週六加班", "title": "麥當勞", "isFinish": "false", "date": "Timestamp(seconds=1599840000, nanoseconds=0)", "total": 374, "sharers": [{"flag": 0, "name": "PoYi", "price": 120}, {"flag": 0, "name": "Sara", "price": 80}]}

*/
