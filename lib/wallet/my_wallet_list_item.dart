import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class MyWalletListItem extends StatefulWidget {
  const MyWalletListItem({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyWalletListItemState();
}

class _MyWalletListItemState extends State<MyWalletListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        children: [
          Container(
            child: Image.asset(
              "imgs/logo@2x.png",
              width: 45,
              height: 45,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "500RSG",
              style: TextStyle(
                  color: color_707070(),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          )),
          Container(
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: mainColor(),
            ),
          )
        ],
      ),
    );
  }
}
