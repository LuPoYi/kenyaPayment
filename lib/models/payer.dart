import 'package:cloud_firestore/cloud_firestore.dart';

class Payer {
  String name;
  int price;
  DocumentReference reference;
  Payer(this.name, {this.price, this.reference});
  factory Payer.fromJson(Map<dynamic, dynamic> json) => _payerFromJson(json);
  Map<dynamic, dynamic> toJson() => _payerToJson(this);

  @override
  String toString() => "Payer<$name>";
}

Payer _payerFromJson(Map<dynamic, dynamic> json) {
  return Payer(json['name'] as String, price: json['price']);
}

Map<dynamic, dynamic> _payerToJson(Payer instance) => <dynamic, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };

//    date: json['date'] == null ? null : (json['date'] as Timestamp).toDate(),
