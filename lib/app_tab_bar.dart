import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppTabBar extends StatefulWidget {
  final Function(int) click;
  final double bottom;

  const AppTabBar({Key? key, required this.bottom, required this.click})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppTabBar();
}

class _AppTabBar extends State<AppTabBar> {
  int page = 1;

  List<Icon> normalImage = const [
    Icon(
      Icons.store_rounded,
      color: Color(0xffD4D4D4),
      size: 22,
    ),
    Icon(
      Icons.home,
      color: Color(0xffD4D4D4),
      size: 22,
    ),
    Icon(
      Icons.account_balance_wallet,
      color: Color(0xffD4D4D4),
      size: 22,
    ),
    Icon(
      Icons.account_circle,
      color: Color(0xffD4D4D4),
      size: 22,
    ),
  ];
  List<Icon> selectImg = const [
    Icon(
      Icons.store_rounded,
      color: Color(0xff00A6BE),
      size: 22,
    ),
    Icon(
      Icons.home,
      color: Color(0xff00A6BE),
      size: 22,
    ),
    Icon(
      Icons.account_balance_wallet,
      color: Color(0xff00A6BE),
      size: 22,
    ),
    Icon(
      Icons.account_circle,
      color: Color(0xff00A6BE),
      size: 22,
    ),
  ];
  final List<String> _list = const ["MarketPlace", "Dashboard", "My Wallet", "Account"];

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
    return page == value ? Color(0xFF00A6BE) : Color(0xffD4D4D4);
  }

  void onPageChanged(int page) {
    setState(() {
      page = page;
    });
  }

  Icon getImageStr(int value) {
    return page == value ? selectImg[value] : normalImage[value];
  }
}
