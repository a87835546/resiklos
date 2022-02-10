import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/clip_borad_tool.dart';
import 'package:resiklos/utils/http_manager.dart';

class HomeReferralsShareWidget extends StatelessWidget {
  const HomeReferralsShareWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("invite code ${AppSingleton.userInfoModel?.inviteCode}");
    bool hasInviteCode = AppSingleton.userInfoModel?.inviteCode != null &&
        AppSingleton.userInfoModel?.inviteCode != "";
    return Container(
      height: 150,
      color: Color(0xffFAFAFA),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              child: hasInviteCode
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                  color: Color(0xff00A6BE), width: 1)),
                          alignment: Alignment.center,
                          child: Text(
                            AppSingleton.userInfoModel?.inviteCode ??
                                "x3yd76cv",
                            style: const TextStyle(
                                color: Color(0xff00A6BE),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            log("copied content ${AppSingleton.userInfoModel?.inviteCode ?? "x3yd76cv"}");
                            ClipboardTool.setDataToast(
                                AppSingleton.userInfoModel?.inviteCode ??
                                    "x3yd76cv");
                          },
                          child: Container(
                            child: const Icon(
                              Icons.content_copy,
                              color: Color(0xff00A6BE),
                            ),
                          ),
                        )
                      ],
                    )
                  : FutureBuilder(
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasError ||
                            snapshot.data == "" ||
                            snapshot.data == null) {
                          return Container(
                            child: null,
                          );
                        } else {
                          String v =  snapshot.data as String;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                        color: Color(0xff00A6BE), width: 1)),
                                alignment: Alignment.center,
                                child: Text(
                                  v,
                                  style: const TextStyle(
                                      color: Color(0xff00A6BE),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  log("copied content ${v}");
                                  ClipboardTool.setDataToast(v);
                                },
                                child: Container(
                                  child: const Icon(
                                    Icons.content_copy,
                                    color: Color(0xff00A6BE),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      },
                      future: getUserInfo(),
                    )),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: const Text(
              "My Referral Code",
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff00A6BE),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Future<String> getUserInfo() async {
    var result = await HttpManager.get(
        url: "user/getInviteCode?id=${AppSingleton.userInfoModel?.id}");
    String code = "";
    log("get invite code --- >> $result");
    try {
      code = result["data"]["code"];
    } catch (e) {
      log("get invite code error ---->>> $e");
    }
    return Future.value(code);
  }
}
