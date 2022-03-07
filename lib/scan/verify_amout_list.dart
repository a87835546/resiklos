import 'package:flutter/cupertino.dart';
import 'package:resiklos/scan/transfer_amout_item.dart';
import 'package:resiklos/utils/color.dart';

class VerifyAmountList extends StatefulWidget {
  final num weight;
  final num price;

  const VerifyAmountList({Key? key, required this.weight, required this.price})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifyAmountListState();
}

class _VerifyAmountListState extends State<VerifyAmountList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TransferAmountItem(
            title: "Weight",
            amount: "${widget.weight} Kilos",
            textStyle:const TextStyle(
              color: Color(0xff707070),
              fontSize: 14,
            ),
          ),
          TransferAmountItem(
            title: "RP pre kilo",
            amount: "${widget.price} RP",
            textStyle:const TextStyle(
              color: Color(0xffD4D4D4),
              fontSize: 14,
            ),
          ),
          TransferAmountItem(
            title: "Total",
            amount: "${(widget.weight * widget.price).toStringAsFixed(2)} RP",
            textStyle: TextStyle(
                color: mainColor(), fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
