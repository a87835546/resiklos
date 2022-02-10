import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppTabBar extends StatefulWidget {
  final Function(int) click;
  final double bottom;

  const AppTabBar({Key? key, required this.bottom,required this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppTabBar();
}

class _AppTabBar extends State<AppTabBar> {
  int page = 1;

  List<Icon> NomalImg = [
    Icon(
      Icons.qr_code_scanner,
      color: Color(0xffD4D4D4),
      size: 22,
    ),
    Icon(
      Icons.home,
      color: Color(0xffD4D4D4),
      size: 22,
    ),
    Icon(
      Icons.videogame_asset,
      color: Color(0xffD4D4D4),
      size: 22,
    ),
  ];
  List<Icon> SeletImg = [
    Icon(
      Icons.qr_code_scanner,
      color: Color(0xff00A6BE),
      size: 22,
    ),
    Icon(
      Icons.home,
      color: Color(0xff00A6BE),
      size: 22,
    ),
    Icon(
      Icons.videogame_asset,
      color: Color(0xff00A6BE),
      size: 22,
    ),
  ];
  List<String> _list = ["SCAN", "HOME", "PLAY"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight + widget.bottom,
      child: Container(
        padding: EdgeInsets.only(bottom: widget.bottom),
        color: Colors.white,
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _list.map((e) {
            return GestureDetector(
                onTap: () {
                  widget.click(_list.indexOf(e));
                  setState(() {
                    page = _list.indexOf(e);
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width / _list.length,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 6),
                          child: getImageStr(_list.indexOf(e))),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          e,
                          style: TextStyle(
                              color: getColor(_list.indexOf(e)),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ));
          }).toList(),
        ),
      ),
    );
  }

  Color getColor(int value) {
    return this.page == value ? Color(0xFF00A6BE) : Color(0xffD4D4D4);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  Icon getImageStr(int value) {
    return this.page == value ? SeletImg[value] : NomalImg[value];
  }
}
