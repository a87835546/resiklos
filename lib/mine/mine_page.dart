import 'dart:developer';

import 'package:adobe_xd/blend_mask.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/home_verify_emal_page.dart';
import 'package:resiklos/home/home_verify_state_icon.dart';
import 'package:resiklos/home/kyc/kyc_start_page.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/toast.dart';
import 'package:resiklos/wallet/home_verify_widget.dart';
import 'package:resiklos/wallet/setup_wallet_step1_page.dart';

class MinePage extends BaseStatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _MinePageState();
}

class _MinePageState extends BaseStatefulState<MinePage> {
  @override
  Widget build(BuildContext context) {
    log("url ----->>>>${AppSingleton.userInfoModel?.avatar != null}");
    return Scaffold(
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(80),
                        blurRadius: 5.0,
                        offset: const Offset(0, 4),
                        spreadRadius: 0)
                  ]),
              child: Column(
                children: [
                  Container(
                    height: 15,
                  ),
                  AppSingleton.userInfoModel?.avatar != "" &&
                          AppSingleton.userInfoModel?.avatar != null
                      ? ClipRRect(
                          child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.redAccent,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withAlpha(80),
                                    blurRadius: 5.0,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 0)
                              ]),
                              padding: const EdgeInsets.all(4),
                              child: FadeInImage.assetNetwork(
                                placeholder: "imgs/placeholder_avatar.png",
                                image: AppSingleton.userInfoModel?.avatar ?? "",
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              )),
                          borderRadius: BorderRadius.circular(50),
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withAlpha(80),
                                    blurRadius: 2.0,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0)
                              ]),
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              width: 90,
                              height: 90,
                              child: Image.asset(
                                "imgs/placeholder_avatar.png",
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(45),
                          )),
                  Container(
                    child: Text(
                      "${AppSingleton.userInfoModel?.nickName ?? "123"}",
                      style: TextStyle(
                          color: mainTitleColor(),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      "ID:${AppSingleton.userInfoModel?.userId}",
                      style: TextStyle(
                          color: Color(0xffD4D4D4),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [

              ],
            )
          ],
        ),
      ),
    );
  }
}
