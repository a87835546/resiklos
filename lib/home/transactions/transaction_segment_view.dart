import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/transactions/transaction_segment_button.dart';

typedef DepositTransactionSegmentViewClick = Function(int);

class DepositTransactionSegmentView extends StatefulWidget {
  final DepositTransactionSegmentViewClick click;
  final int index;
  const DepositTransactionSegmentView({Key? key, required this.click,required this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositTransactionSegmentViewState();
}

class _DepositTransactionSegmentViewState
    extends State<DepositTransactionSegmentView> {
  var select = "REWARDS";
 static const  List list = [
   'REWARDS',
   'TRANSFER',
   'EXCHANGE',
 ];
  @override
  Widget build(BuildContext context) {
    setState(() {
      select = list[widget.index];
    });
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
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
