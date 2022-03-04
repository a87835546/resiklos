import 'package:flutter/cupertino.dart';

class TransferAmountItem extends StatefulWidget {
  final String title;
  final String amount;
  final TextStyle textStyle;

  const TransferAmountItem(
      {Key? key,
      required this.title,
      required this.amount,
      required this.textStyle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransferAmountItemState();
}

class _TransferAmountItemState extends State<TransferAmountItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              widget.title,
              style: widget.textStyle,
            ),
          ),
          Container(
            child: Text(
              "${widget.amount} RSG",
              style: widget.textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
