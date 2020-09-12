import 'package:cloud_firestore/cloud_firestore.dart';
import 'payer.dart';
import 'sharer.dart';

class Order {
  String title;
  String memo;
  DateTime date;
  int total;
  bool isFinish;
  List<Payer> payers = List<Payer>();
  List<Sharer> sharers = List<Sharer>();
  DocumentReference reference;
  Order(this.title,
      {this.memo,
      this.date,
      this.total,
      this.isFinish,
      this.payers,
      this.sharers,
      this.reference});

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    Order newOrder = Order.fromJson(snapshot.data());
    newOrder.reference = snapshot.reference;
    return newOrder;
  }

  factory Order.fromJson(Map<String, dynamic> json) => _orderFromJson(json);

  Map<String, dynamic> toJson() => _orderToJson(this);
  @override
  String toString() => "Order<$title>";
}

Order _orderFromJson(Map<String, dynamic> json) {
  return Order(json['title'],
      memo: json['memo'],
      total: json['total'],
      isFinish: json['isFinish'],
      date: json['date'] == null ? null : (json['date'] as Timestamp).toDate(),
      payers: _convertPayers(json['payers'] as List),
      sharers: _convertSharers(json['sharers'] as List));
}

List<Payer> _convertPayers(List payerMap) {
  if (payerMap == null) {
    return null;
  }
  List<Payer> payers = List<Payer>();
  payerMap.forEach((value) {
    payers.add(Payer.fromJson(value));
  });
  return payers;
}

List<Sharer> _convertSharers(List sharerMap) {
  if (sharerMap == null) {
    return null;
  }
  List<Sharer> sharers = List<Sharer>();
  sharerMap.forEach((value) {
    sharers.add(Sharer.fromJson(value));
  });
  return sharers;
}

Map<String, dynamic> _orderToJson(Order instance) => <String, dynamic>{
      'title': instance.title,
      'memo': instance.memo,
      'date': instance.date,
      'payers': _payerList(instance.payers),
      'sharers': _sharerList(instance.sharers),
    };

List<Map<String, dynamic>> _payerList(List<Payer> payers) {
  if (payers == null) {
    return null;
  }
  List<Map<String, dynamic>> payerMap = List<Map<String, dynamic>>();
  payers.forEach((payer) {
    payerMap.add(payer.toJson());
  });
  return payerMap;
}

List<Map<String, dynamic>> _sharerList(List<Sharer> sharers) {
  if (sharers == null) {
    return null;
  }
  List<Map<String, dynamic>> sharerMap = List<Map<String, dynamic>>();
  sharers.forEach((sharer) {
    sharerMap.add(sharer.toJson());
  });
  return sharerMap;
}
