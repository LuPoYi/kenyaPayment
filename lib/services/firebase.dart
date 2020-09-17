import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenyaPayment/models/order.dart';
import 'package:kenyaPayment/common/variable.dart';

class FirebaseService {
  static createOrder(Order order) {
    FirebaseFirestore.instance
        .collection(ordersCollection)
        .add(order.toJson())
        .catchError((e) {
      print(e.toString());
    });
  }

  static createMessage(Map<String, dynamic> chatMessageMap) {
    FirebaseFirestore.instance
        .collection("rooms")
        .doc("yJreT4x8Fr37dP6h55qq")
        .collection("messages")
        .add(chatMessageMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
// class DatabaseMethods{
//   getUserByUserName(String username){

//   }

//   upload
// }
