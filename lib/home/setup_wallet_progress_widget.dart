import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class SetupWalletProgressWidget extends StatefulWidget {
  final int step;

  const SetupWalletProgressWidget({Key? key, required this.step})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SetupWalletProgressWidgetState();
}

class _SetupWalletProgressWidgetState extends State<SetupWalletProgressWidget> {
  TextStyle selected = const TextStyle(
      color: CupertinoColors.white, fontWeight: FontWeight.bold, fontSize: 18);
  TextStyle unselected = TextStyle(
      color: mainTitleColor(), fontWeight: FontWeight.bold, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: mainColor(), borderRadius: BorderRadius.circular(10)),
            child: Text(
              "1",
              style: selected,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Divider(
              height: 1,
              color: mainTitleColor(),
            ),
          )),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: mainTitleColor(), width: 1)),
            child: Text(
              "2",
              style: unselected,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Divider(
              height: 1,
              color: mainTitleColor(),
            ),
          )),
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: mainTitleColor(), width: 1)),
            child: Text(
              "3",
              style: unselected,
            ),
          ),
        ],
      ),
    );
  }
}
