import 'package:cloud_firestore/cloud_firestore.dart';

class Sharer {
  String name;
  int price;
  int flag;
  DocumentReference reference;
  Sharer(this.name, {this.price, this.flag, this.reference});
  factory Sharer.fromJson(Map<dynamic, dynamic> json) => _payerFromJson(json);
  Map<dynamic, dynamic> toJson() => _payerToJson(this);

  @override
  String toString() => "Sharer<$name>";
}

Sharer _payerFromJson(Map<dynamic, dynamic> json) {
  return Sharer(json['name'] as String,
      price: json['price'], flag: json['flag']);
}

Map<dynamic, dynamic> _payerToJson(Sharer instance) => <dynamic, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'flag': instance.flag,
    };
