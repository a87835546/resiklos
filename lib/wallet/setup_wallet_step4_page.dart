import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/bottom_navigationbar.dart';
import 'package:resiklos/utils/toast.dart';
import 'package:resiklos/wallet/setup_wallet_progress_widget.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';

class SetupWalletStep4Page extends BaseStatefulWidget {
  final List<String> seedPhares;

  const SetupWalletStep4Page({Key? key, required this.seedPhares})
      : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() =>
      _SetupWalletStep4PageState();
}

class _SetupWalletStep4PageState
    extends BaseStatefulState<SetupWalletStep4Page> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  List<int> randoms = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      randoms.add(Random().nextInt(12));
    }
    dev.log("random charset --->>$randoms");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 45, right: 45),
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
                    step: 3,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                alignment: Alignment.center,
                child: const Text(
                  "Please confirm your seedphrase by filling in the correct word for each number.",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "#${randoms[1]}",
                                style: TextStyle(
                                    color: mainTitleColor(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              // width: 140,
                              height: 45,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: mainTitleColor(), width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 5)),
                                controller: _controller1,
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "#${randoms[0]}",
                                style: TextStyle(
                                    color: mainTitleColor(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: mainTitleColor(), width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 5)),
                                controller: _controller2,
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "#${randoms[2]}",
                                style: TextStyle(
                                    color: mainTitleColor(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              // width: 140,
                              height: 45,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: mainTitleColor(), width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 5)),
                                controller: _controller3,
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "#${randoms[3]}",
                                style: TextStyle(
                                    color: mainTitleColor(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: mainTitleColor(), width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 5)),
                                controller: _controller4,
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 1,
                    ),
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
                      "Done",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (widget.seedPhares[randoms[0]] == _controller1.text &&
                      widget.seedPhares[randoms[1]] == _controller2.text &&
                      widget.seedPhares[randoms[2]] == _controller3.text &&
                      widget.seedPhares[randoms[3]] == _controller4.text) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (ctx) {
                      return CustomBottomNavigationBar();
                    }), (route) => false);
                  } else {
                    showErrorText("Input the seed phares is mistake");
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
