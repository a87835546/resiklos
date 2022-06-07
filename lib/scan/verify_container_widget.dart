import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/qr_code_dailog.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:share_plus/share_plus.dart';

class VerifySuccessfullyContainerView extends StatefulWidget {
  final num amount;
  final num kilos;

  const VerifySuccessfullyContainerView(
      {Key? key, required this.amount, required this.kilos})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _VerifySuccessfullyContainerViewState();
}

class _VerifySuccessfullyContainerViewState
    extends State<VerifySuccessfullyContainerView> {
  String text = 'title';
  String subject = 'subtitle';
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
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
                        "${widget.kilos}",
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
                        "Grams",
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
                        "Weight",
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
                        "${(widget.amount * widget.kilos).toStringAsFixed(2)} RP",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.maxFinite,
                      child: Text(
                        "QR CODE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3),
                      width: double.maxFinite,
                      child: Text(
                        "rp:${AppSingleton.userInfoModel?.rpWalletAddress}",
                        style: TextStyle(color: mainColor(), fontSize: 12),
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
