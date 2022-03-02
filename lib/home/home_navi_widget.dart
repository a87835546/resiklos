import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/setting/setting_page.dart';
import 'package:resiklos/home/transactions/transaction_page.dart';
import 'package:resiklos/sign_up_in/sign_request.dart';
import 'package:resiklos/utils/app_singleton.dart';

import 'notification/notification_page.dart';

class HomeNaviView extends StatefulWidget {
  final double top;

  const HomeNaviView({Key? key, required this.top}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeNaviViewState();
}

class _HomeNaviViewState extends State<HomeNaviView> {
  @override
  Widget build(BuildContext context) {
    log("url---->>>>>${AppSingleton.userInfoModel?.avatar}");
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: widget.top),
      height: (65.0 + widget.top),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(80),
              blurRadius: 5.0,
              offset: Offset(0, 4),
              spreadRadius: 0)
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 72,
            width: 72,
            child: OverflowBox(
                maxHeight: 200,
                maxWidth: 200,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.grey.withAlpha(130),
                      //       blurRadius: 5.0,
                      //       offset: Offset(0, 4),
                      //       spreadRadius: 3)
                      // ],
                    ),
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: AppSingleton.userInfoModel?.avatar == "" ||
                                  AppSingleton.userInfoModel?.avatar == null
                              ? Image.asset("imgs/placeholder_avatar.png")
                              : FadeInImage.assetNetwork(
                                  placeholder: "imgs/placeholder_avatar.png",
                                  image:
                                      AppSingleton.userInfoModel?.avatar ?? "",
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                )),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 6),
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppSingleton.userInfoModel?.nickName ?? "JOHN DELA CRUZ",
                      style: const TextStyle(
                          color: Color(0xff707070),
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "imgs/badge-unverified.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icons.history,
                  Icons.notifications_active_rounded,
                  Icons.settings
                  // Icons.logout
                ].map((e) {
                  return GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                          child: Icon(
                        e,
                        size: 22,
                        color: Color(0xff00A6BE),
                      )),
                    ),
                    onTap: () {
                      if (e == Icons.settings) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const SettingPage();
                        }));
                      } else if (e == Icons.history) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const TransactionPage();
                        }));
                      } else if (e == Icons.notifications_active_rounded) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const NotificationPage();
                        }));
                      }else if(e == Icons.logout){
                        SignRequest.logout(context);
                      }
                    },
                  );
                }).toList()),
          )
        ],
      ),
    );
  }
}
