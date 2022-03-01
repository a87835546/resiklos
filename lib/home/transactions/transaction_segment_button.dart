import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DepositButtonClick = Function(String);

class DepositButton extends StatefulWidget {
  final String title;
  final bool selected;
  final DepositButtonClick click;

  const DepositButton(
      {Key? key,
      required this.title,
      required this.selected,
      required this.click})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepositButtonState();
}

class _DepositButtonState extends State<DepositButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.click(widget.title);
        log('click deposit button ${widget.title}');
      },
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: widget.selected ? Color(0xff00A6BE) : Color(0xffD4D4D4),
              ),
            ),
            IntrinsicWidth(
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                  height: 3,
                  width: 70,
                  color:
                      widget.selected ? Color(0xff00A6BE) : Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
