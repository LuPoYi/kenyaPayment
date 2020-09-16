import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';

class Detail extends StatelessWidget {
  final Order order;
  const Detail({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(order.title,
          style: TextStyle(fontSize: 24, color: Colors.redAccent)),
      Text(order.total.toString()),
      Text(DateFormat('MM/dd').format(order.date)),
      Text(order.isFinish ? "訂單狀態: 已結束" : "訂單狀態: 尚欠款"),
      Text("-----"),
      Text("付款人"),
      ...order.payers
          .map((payer) => Text("${payer.name}: ${payer.price}"))
          .toList(),
      Text("-----"),
      ...order.sharers
          .map((sharer) => Text(
              "${sharer.name}: ${sharer.price} ${sharer.flag == 0 ? '未付' : '已付'}"))
          .toList(),
    ]);
  }
}
