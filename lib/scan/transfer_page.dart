import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/scan/transfer_amout_list.dart';
import 'package:resiklos/scan/transfer_wallet_view.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';

class TransferPage extends BaseStatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _TransferPageState();
}

class _TransferPageState extends BaseStatefulState<TransferPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.grey,
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  height: 460,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.maxFinite,
                                      child: const Text(
                                        "SEND RSG",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Text(
                                      "Send RSG to another RSG wallet. This transaction is not reversible. Enter amount to proceed.",
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Color(0xffD4D4D4),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0x7676801F),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                width: 30,
                                height: 30,
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context, "1");
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              width: 120,
                              height: 120,
                              color: const Color(0xffeeeeee),
                              child: const Icon(
                                Icons.image,
                                size: 28,
                              ),
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "QR CODE",
                          style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "rsg:sds123jksdfjkhkj",
                          style: TextStyle(
                              color: mainColor(),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TransferWalletView(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TransferAmountList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  height: 80,
                  color: mainColor(),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "SEND 101.5 RSG",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                    onTap: () {
                      log("send rsg");
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context, "1");
          return true;
        });
  }
}
