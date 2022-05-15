import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/kyc/kyc_frist_page.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/toast.dart';
import 'package:resiklos/wallet/abi/contracts.dart';
import 'package:resiklos/wallet/setup_wallet_progress_widget.dart';
import 'package:resiklos/wallet/setup_wallet_step3_page.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/wallet/wallet_model.dart';
import 'package:resiklos/wallet/wallet_request.dart';

class SetupWalletStep2Page extends BaseStatefulWidget {
  const SetupWalletStep2Page({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() =>
      _SetupWalletStep2PageState();
}

class _SetupWalletStep2PageState
    extends BaseStatefulState<SetupWalletStep2Page> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log("message---->>>>${AppSingleton.userInfoModel?.email}");
    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
        bgColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 45, right: 45),
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
                  "Set Wallet Password",
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
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: SetupWalletProgressWidget(
                    step: 1,
                  )),
              Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: const Text(
                  "Set a secure password for your wallet. Use this password to unlock your wallet",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: const Text(
                              "Password",
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            child: const Text(
                              "At least 8 characters",
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Enter a password",
                            hintStyle: TextStyle(
                                color: mainTitleColor(),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.remove_red_eye_outlined,
                              size: 16,
                              color: mainTitleColor(),
                            )),
                        controller: _passwordController,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: const Text(
                              "Confirm Password",
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Re-enter the password",
                            hintStyle: TextStyle(
                                color: mainTitleColor(),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.remove_red_eye_outlined,
                              size: 16,
                              color: mainTitleColor(),
                            )),
                        controller: _confirmController,
                      ),
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
                      "Create Wallet",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  log("start verify kyc");
                  if (_passwordController.text == _confirmController.text &&
                      _passwordController.text.length > 7) {
                    String seed = Blockchain.generateSeedPhrase();
                    if (null != seed) {
                      List<String> temp = seed.split(" ");
                      log("seed phares --->>>$temp");
                      NavigatorUtil.push(
                          context,
                          SetupWalletStep3Page(
                            seedPhares: temp,
                          ));
                    }
                  } else {
                    showErrorText("Please input correct password");
                    return;
                  }
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
