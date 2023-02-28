import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class MyWalletButtonWidget extends StatefulWidget {
  final Function(int) clickItem;

  const MyWalletButtonWidget({Key? key, required this.clickItem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyWalletButtonWidgetState();
}

class _MyWalletButtonWidgetState extends State<MyWalletButtonWidget> {
  final List<String> titles = ["Deposit", "Transfer", "Swap"];
  final List images = [
    Icons.account_balance_wallet,
    Icons.send,
    Icons.swap_vert
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: titles.map((e) {
          int index = titles.indexOf(e);
          return Container(
            height: 55,
            width: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x29000000),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                      spreadRadius: 0)
                ],
                color: Colors.white),
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      images[index],
                      size: 30,
                      color: mainColor(),
                    ),
                  ),
                  Container(
                    child: Text(
                      e,
                      style: TextStyle(
                          color: mainColor(),
                          fontSize: 10,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
              onTap: () {
                widget.clickItem(index);

              },
              behavior: HitTestBehavior.opaque,
            ),
          );
        }).toList(),
      ),
    );
  }
}
