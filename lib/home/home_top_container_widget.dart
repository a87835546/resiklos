import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resiklos/home/qr_code_dailog.dart';
import 'package:resiklos/utils/navigator_util.dart';

import 'home_button_widget.dart';
import 'home_referrals_page.dart';

class HomeTopContainerView extends StatefulWidget {
  final num count;
  final num points;

  const HomeTopContainerView(
      {Key? key, required this.count, required this.points})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTopContainerViewState();
}

class _HomeTopContainerViewState extends State<HomeTopContainerView> {
  List<HomeButtonModel> _list = [];

  @override
  void initState() {
    super.initState();
    _list = [
      HomeButtonModel(Icons.qr_code, "QR", () async {}),
      HomeButtonModel(Icons.send_sharp, "Send", () async {}),
      HomeButtonModel(Icons.group_sharp, "Referrals", () async {}),
      HomeButtonModel(Icons.import_export, "Exchange", () async {}),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(80),
              blurRadius: 5.0,
              offset: Offset(0, 4),
              spreadRadius: 1),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 156,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withAlpha(80),
                      blurRadius: 5.0,
                      offset: Offset(0, 4),
                      spreadRadius: 1),
                ],
                // gradient: const LinearGradient(
                //     colors: [Color(0xff00A6BE), Color(0xff00F5D9)],
                // ),
                image: const DecorationImage(
                    image: AssetImage("imgs/summary-bg.png"),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.points}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "RSG",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Resiklos Gems",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.count} Referrals",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 70),
                  child: Container(
                    height: 100,
                    width: 132,
                    color: Colors.transparent,
                    child: OverflowBox(
                      maxWidth: 132,
                      maxHeight: 127,
                      child: Image.asset("imgs/logo@2x.png"),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 30, top: 20, right: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _list.map((e) {
                    return HomeButtonWidget(
                      model: e,
                      click: () {
                        log("click index ${_list.indexOf(e)} value ${e.title}");
                        if (_list.indexOf(e) == 2) {
                          NavigatorUtil.push(context, HomeReferrals());
                        } else if (_list.indexOf(e) == 0) {
                          showCustomDialog(context);
                        }
                      },
                    );
                  }).toList()),
            ),
          )
        ],
      ),
    );
  }
}

class HomeButtonModel {
  IconData url;
  String title;
  Function? click;

  HomeButtonModel(this.url, this.title, this.click);
}
