import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resiklos/home/kyc/personal_info.dart';
import 'package:resiklos/home/setting/setting_page.dart';
import 'package:resiklos/home/transactions/transaction_page.dart';
import 'package:resiklos/sign_up_in/sign_request.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/constants.dart';
import 'package:resiklos/utils/navigator_util.dart';

import 'notification/notification_page.dart';

class HomeNaviView extends StatefulWidget {
  final double top;

  const HomeNaviView({Key? key, required this.top}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeNaviViewState();
}

class _HomeNaviViewState extends State<HomeNaviView> {
  static const bool _debug = kDebugMode;

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {
                        NavigatorUtil.push(context, PersonalInfoPage());
                      },
                      behavior: HitTestBehavior.opaque,
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
                      AppSingleton.userInfoModel?.fullName ?? "JOHN DELA CRUZ",
                      style: const TextStyle(
                          color: Color(0xff707070),
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // Container(
                  //     height: 20, alignment: Alignment.centerLeft, child: null
                  //     // Image.asset(
                  //     //   "imgs/badge-unverified.png",
                  //     // ),
                  //     ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: (_debug
                        ? [
                            Icons.history,
                            Icons.qr_code_rounded,
                            Icons.notifications_active_rounded,
                            Icons.settings
                            // Icons.logout
                          ]
                        : [Icons.history, Icons.qr_code_rounded])
                    .map((e) {
                  return GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                          child: e != Icons.notifications_active_rounded
                              ? Icon(
                                  e,
                                  size: 22,
                                  color: Color(0xff00A6BE),
                                )
                              : Badge(
                                  position:
                                      BadgePosition.topEnd(top: -12, end: -8),
                                  badgeContent: Text(""),
                                  child: Icon(
                                    e,
                                    size: 22,
                                    color: Color(0xff00A6BE),
                                  ),
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
                      } else if (e == Icons.logout) {
                        SignRequest.logout(context);
                      } else if (e == Icons.qr_code_rounded) {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor: Colors.white,
                            builder: (context) {
                              return FractionallySizedBox(
                                heightFactor: 0.83,
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 30),
                                    height: double.infinity,
                                    width: 300,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Scan QR Code',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                          ),
                                          width: 300,
                                          child: const Text(
                                            'Receive RP via QR code. Show this to other Resiklos users and scan to send',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        QrImage(
                                          data:
                                              "${AppSingleton.userInfoModel?.rpWalletAddress}",
                                          version: 4,
                                          size: 300,
                                          gapless: false,
                                          eyeStyle: const QrEyeStyle(
                                              eyeShape: QrEyeShape.square,
                                              color: ResiklosColors.primary),
                                          dataModuleStyle:
                                              const QrDataModuleStyle(
                                                  dataModuleShape:
                                                      QrDataModuleShape.circle,
                                                  color: ResiklosColors
                                                      .primaryDark),
                                          embeddedImage: const AssetImage(
                                              'imgs/logo@2x.png'),
                                          embeddedImageStyle:
                                              QrEmbeddedImageStyle(
                                            size: const Size(65, 65),
                                          ),
                                          errorStateBuilder: (cxt, err) {
                                            return const Center(
                                              child: Text(
                                                "Uh oh! Something went wrong...",
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          },
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 20,
                                          ),
                                          width: 300,
                                          child: const Text(
                                            'Scan using Resiklos "Scan QR"',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 10),
                                              margin: EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                color: ResiklosColors.light,
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                'RP Wallet Address:',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: ResiklosColors.light,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Text(
                                                  '${AppSingleton.userInfoModel?.rpWalletAddress}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            });
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
