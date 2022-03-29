import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/kyc/kyc_frist_page.dart';
import 'package:resiklos/wallet/setup_wallet_progress_widget.dart';
import 'package:resiklos/wallet/setup_wallet_step4_page.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/clip_borad_tool.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';

class SetupWalletStep3Page extends BaseStatefulWidget {
  final List<String> seedPhares;

  const SetupWalletStep3Page({Key? key, required this.seedPhares})
      : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() =>
      _SetupWalletStep3PageState();
}

class _SetupWalletStep3PageState
    extends BaseStatefulState<SetupWalletStep3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Image.asset(
                  "imgs/wallet-header.png",
                  width: 120,
                  height: 120,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Seedphrase",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: const Text(
                  "Let’s create your new wallet",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  alignment: Alignment.center,
                  child: const SetupWalletProgressWidget(
                    step: 2,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                alignment: Alignment.center,
                child: const Text(
                  "Please note down your seedphrase and keep it in a safe place. Never give this phrase to anyone!",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 235,
                decoration: BoxDecoration(
                  color: Color(0xffF7FAFC),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Container(
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          //主方向的Item间隔 竖直方向
                          mainAxisSpacing: 12,
                          //次方向的Item间隔
                          crossAxisSpacing: 12,
                          //子Item 的宽高比
                          childAspectRatio: 2.6,
                          //每行4列
                          crossAxisCount: 3,
                        ),
                        children:
                            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].map((e) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text("$e."),
                                ),
                                Container(
                                  height: 25,
                                  width: 75,
                                  // padding: const EdgeInsets.only(
                                  //     left: 10, right: 10, bottom: 2, top: 2),

                                  child: Text("${widget.seedPhares[e]}"),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      height: 210,
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.copy,
                              color: mainColor(),
                              size: 16,
                            ),
                            Text(
                              "Copy to clipboard",
                              style: TextStyle(
                                  color: mainColor(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        log("copy content---->>>${jsonEncode(widget.seedPhares)}");
                        ClipboardTool.setDataToast(
                            jsonEncode(widget.seedPhares));
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                      color: mainColor(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    width: 232,
                    height: 50,
                    child: const Text(
                      "Confirm Seedphrase",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  log("start verify kyc");
                  NavigatorUtil.push(context, SetupWalletStep4Page());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bullet() {
    return SvgPicture.string(
      '<svg viewBox="76.0 381.0 11.0 11.0" ><path transform="translate(75.44, 380.44)" d="M 6.062500476837158 0.5625 C 3.024925470352173 0.5625 0.5625 3.024925470352173 0.5625 6.062500476837158 C 0.5625 9.100074768066406 3.024925470352173 11.5625 6.062500476837158 11.5625 C 9.100074768066406 11.5625 11.5625 9.100074768066406 11.5625 6.062500476837158 C 11.5625 3.024924993515015 9.10007381439209 0.5625 6.062500476837158 0.5625 Z M 7.83669376373291 6.062500476837158 C 7.83669376373291 7.040790557861328 7.040790557861328 7.83669376373291 6.062500476837158 7.83669376373291 C 5.08420991897583 7.83669376373291 4.288306713104248 7.040790557861328 4.288306713104248 6.062500476837158 C 4.288306713104248 5.08420991897583 5.08420991897583 4.288306713104248 6.062500476837158 4.288306713104248 C 7.040790557861328 4.288306713104248 7.83669376373291 5.08420991897583 7.83669376373291 6.062500476837158 Z" fill="#00a6be" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
      allowDrawingOutsideViewBox: true,
    );
  }
}
