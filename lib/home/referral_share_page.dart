import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/clip_borad_tool.dart';
import 'package:resiklos/utils/http_manager.dart';

import '../rk_app_bar.dart';

class ReferralPage extends BaseStatefulWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _ReferralPageState();
}

class _ReferralPageState extends BaseStatefulState<ReferralPage> {
  @override
  void initState() {
    super.initState();
    log("code ---->>>> ${AppSingleton.userInfoModel?.inviteCode}");
    if (AppSingleton.userInfoModel?.inviteCode == null ||
        AppSingleton.userInfoModel?.inviteCode == "") {
      getInviteCode();
    }
  }

  var url =
      "www.resiklos.app?code=${AppSingleton.userInfoModel?.inviteCode ?? "x3yd76cv"}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "SHARE",
      ),
      body: MediaQuery.removePadding(
        context: context,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  child: Container(
                    child: Image.asset(
                      "imgs/onboarding-mascot.png",
                      width: 246,
                      height: 175,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          "SHARE NOW",
                          style: TextStyle(
                              color: Color(0xff00BEBE),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        child: const Text(
                          "Earn rewards. Invite your friends",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 300,
                        alignment: Alignment.center,
                        child: const Text(
                          "Share with your friends and earn +50 RSGP on every successful invite",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                  color: Color(0xff00A6BE), width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    url,
                                    style: const TextStyle(
                                        color: Color(0xff00A6BE),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  log("copied content $url");
                                  ClipboardTool.setDataToast(url);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Container(
                                    child: const Icon(
                                      Icons.content_copy,
                                      color: Color(0xff00A6BE),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text("Invite people using this link"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        removeTop: false,
        removeBottom: true,
      ),
    );
  }

  Route jump(Widget page) {
    return PageRouteBuilder(
        opaque: true,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                // animation.drive(tween.chain(CurveTween(curve: Curves.ease))),
                Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
                    .animate(animation),
            child: child,
          );
        });
  }

  Future<String> getInviteCode() async {
    var result = await HttpManager.get(
        url: "user/getInviteCode?id=${AppSingleton.userInfoModel?.id}");
    String code = "";
    log("get invite code --- >> $result");
    try {
      code = result["data"]["code"];
    } catch (e) {
      log("get invite code error ---->>> $e");
    }
    setState(() {
      url = "www.resiklos.app?code=${code}";
    });
    return Future.value(code);
  }
}

class SwiperModel {
  String title;
  String desc;

  SwiperModel(this.title, this.desc);
}
