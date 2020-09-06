import 'package:flutter/material.dart';
import '../common/widget.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(children: [
        buildHeader(context),
        _buildOrderList(context),
      ])),
    );
  }

  Widget _buildOrderList(BuildContext context) {
    return Expanded(
        child: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List.generate(10, (idx) {
        return buildOrderCard(idx);
      }),
    ));
  }
}
