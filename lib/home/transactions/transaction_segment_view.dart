import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/transactions/transaction_segment_button.dart';

typedef DepositTransactionSegmentViewClick = Function(int);

class DepositTransactionSegmentView extends StatefulWidget {
  final DepositTransactionSegmentViewClick click;
  final int index;
  final bool isShop;
  final List<String>? titles;

  const DepositTransactionSegmentView(
      {Key? key,
      required this.click,
      required this.index,
      required this.isShop,
      this.titles})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionSegmentViewState();
}

class _DepositTransactionSegmentViewState
    extends State<DepositTransactionSegmentView> {
  var select = "REWARDS";
  static List list = [
    'REWARDS',
    'TRANSFER',
    'EXCHANGE',
  ];
  double leftPadding = 14;

  @override
  void initState() {
    super.initState();
    if (widget.isShop) {
      list = ["MERCHANTS", "VOUCHERS"];
      leftPadding = 50;
    } else {
      list = [
        'REWARDS',
        'TRANSFER',
        'EXCHANGE',
      ];
      leftPadding = 14;
    }
    list = widget.titles ?? list;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      select = list[widget.index];
    });
    return Container(
      height: 60,
      padding: EdgeInsets.only(
          left: leftPadding, right: leftPadding, top: 5, bottom: 5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list.map((e) {
          return DepositButton(
            click: (value) {
              setState(() {
                select = value;
              });
              widget.click(list.indexOf(value));
            },
            selected: select == e,
            title: e,
          );
        }).toList(),
      ),
    );
  }
}
