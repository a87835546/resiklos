import 'package:flutter/cupertino.dart';
import 'package:resiklos/scan/transfer_amout_item.dart';
import 'package:resiklos/utils/color.dart';

class TransferAmountList extends StatefulWidget {
  const TransferAmountList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransferAmountListState();
}

class _TransferAmountListState extends State<TransferAmountList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TransferAmountItem(
            title: "Amount",
            amount: "100.0 RP",
            textStyle: TextStyle(
              color: Color(0xff707070),
              fontSize: 14,
            ),
          ),
          TransferAmountItem(
            title: "Fee",
            amount: "100.0 RP",
            textStyle: TextStyle(
              color: Color(0xffD4D4D4),
              fontSize: 14,
            ),
          ),
          TransferAmountItem(
            title: "Total",
            amount: "100.0 RP",
            textStyle: TextStyle(
              color: mainColor(),
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}
