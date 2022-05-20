import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/kyc/kyc_frist_page.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/clip_borad_tool.dart';
import 'package:resiklos/wallet/import_wallet_page.dart';
import 'package:resiklos/wallet/setup_wallet_step2_page.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupWalletStep1Page extends BaseStatefulWidget {
  const SetupWalletStep1Page({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() =>
      _SetupWalletStep1PageState();
}

class _SetupWalletStep1PageState
    extends BaseStatefulState<SetupWalletStep1Page> {
  @override
  Widget build(BuildContext context) {
    String title = "Please verify KYC first";
    title = AppSingleton.userInfoModel?.kycVerificationStatus == 1
        ? "We are currently processing your KYC Verification Details. Please come back again or contact our support team."
        : title;
    title = AppSingleton.userInfoModel?.kycVerificationStatus == 3
        ? "KYC Verification Rejected. Please upload valid information details, and photos, then try again."
        : title;
    return Container(
      padding: EdgeInsets.only(left: 45, top: kToolbarHeight, right: 45),
      child: AppSingleton.userInfoModel?.kycVerificationStatus != 2
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title),
                  Visibility(
                    child: GestureDetector(
                      child: Text(
                        "support@resiklos.com",
                        style: TextStyle(color: mainColor()),
                      ),
                      onTap: () {
                        ClipboardTool.setDataToast("support@resiklos.com");
                      },
                    ),
                    visible:
                        AppSingleton.userInfoModel?.kycVerificationStatus == 1,
                  )
                ],
              ),
            )
          : Container(
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
                      "Welcome to Resiklos Wallet",
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
                      "Let’s create your secure wallet",
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: const Text(
                      "Before proceeding, please remember:",
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 26,
                            padding: EdgeInsets.only(right: 3),
                            alignment: Alignment.topLeft,
                            child: bullet(),
                          ),
                          Expanded(
                              child: Container(
                            child: const Text(
                              "Never share your 12-word key (seedphrase) to anyone. ",
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                              maxLines: 2,
                            ),
                          )),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 26,
                            padding: EdgeInsets.only(right: 3),
                            alignment: Alignment.topLeft,
                            child: bullet(),
                          ),
                          Expanded(
                              child: Container(
                            child: const Text(
                              "Resiklos team will never ask for your seedphrase ",
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                              maxLines: 2,
                            ),
                          )),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 26,
                            padding: EdgeInsets.only(right: 3),
                            alignment: Alignment.topLeft,
                            child: bullet(),
                          ),
                          Expanded(
                              child: Container(
                            child: const Text(
                              "You may write down your seedphrase in a piece of paper and keep it in a secure place.",
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                              maxLines: 2,
                            ),
                          )),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: const Text(
                      "Disclaimer: Once lost, Resiklos cannot recover your wallet seedphrase. Resiklos don’t store any wallet credentials on its database.",
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
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
                          "START NOW",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      NavigatorUtil.push(context, SetupWalletStep2Page());
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text(
                        "Import wallet using a seedphrase",
                        style: TextStyle(
                            color: mainColor(),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      NavigatorUtil.push(context, ImportWalletPage());
                    },
                  )
                ],
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
