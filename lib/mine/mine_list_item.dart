import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class MineListItem extends StatefulWidget {
  final String title;
  final String? subTitle;
  final Widget? right;

  const MineListItem(
      {Key? key, required this.title, this.subTitle, this.right})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineListItemState();
}

class _MineListItemState extends State<MineListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 45,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: color_707070(),
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: widget.right ??
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.subTitle??"",
                          style: TextStyle(
                              color: color_d4d4d4(),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                  flex: 1,
                ),
              ],
            ),
            flex: 1,
          ),
          Divider(
            color: color_d4d4d4(),
            height: 1,
          )
        ],
      ),
    );
  }
}
