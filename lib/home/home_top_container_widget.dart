import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resiklos/home/my_voucher/vouchers_page.dart';
import 'package:resiklos/home/qr_code_dailog.dart';
import 'package:resiklos/home/summary_button_widget.dart';
import 'package:resiklos/home/summary_card_widget.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/verify_util.dart';
import 'package:resiklos/wallet/transfer_bottom_sheet_widget.dart';
import 'package:share_plus/share_plus.dart';

import 'home_button_widget.dart';
import 'home_referrals_page.dart';

class HomeTopContainerView extends StatefulWidget {
  final String count;
  final num points;
  final num exchangeRate;

  const HomeTopContainerView(
      {Key? key,
      required this.count,
      required this.points,
      required this.exchangeRate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTopContainerViewState();
}

class _HomeTopContainerViewState extends State<HomeTopContainerView> {
  List<HomeButtonModel> _list = [];
  String text = 'title';
  String subject = 'subtitle';
  List<String> imagePaths = [];
  SwiperController _swiperController = SwiperController();

  @override
  void initState() {
    super.initState();
    _list = [
      HomeButtonModel(Icons.qr_code, "QR", () async {}),
      HomeButtonModel(Icons.send_sharp, "Send", () async {}),
      HomeButtonModel(Icons.directions_rounded, "Receive", () async {}),
      HomeButtonModel(Icons.group_sharp, "Referrals", () async {}),
      HomeButtonModel(Icons.import_export, "Exchange", () async {}),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool showRP = (AppSingleton.userInfoModel?.walletAddress == null ||
        AppSingleton.userInfoModel?.walletAddress == "");
    return Container(
      height: 255,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(80),
              blurRadius: 5.0,
              offset: Offset(0, 4),
              spreadRadius: 1),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 160,
            child: Swiper(
              controller: _swiperController,
              loop: false,
              itemCount: (!showRP ? 2 : 1),
              itemBuilder: (BuildContext context, int index) {
                log("index --->>>$index show rp --->>>$showRP");
                return Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: const Alignment(1.132, -1.192),
                              end: const Alignment(-1.0, 1.0),
                              colors: index == 0
                                  ? [
                                      const Color(0xFFE8A81A),
                                      const Color(0xFFF4BB3C)
                                    ]
                                  : [
                                      const Color(0xff00f5d9),
                                      const Color(0xff00a6be)
                                    ],
                              stops: const [0.0, 1.0],
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(left: 39.0),
                          child: SizedBox(
                            height: 160.0,
                            child: SvgPicture.asset('imgs/svg/summary_bg.svg',
                                allowDrawingOutsideViewBox: true,
                                height: double.infinity),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: double.maxFinite,
                                      child: Text(
                                        index == 0
                                            ? "Resiklos Points "
                                            : "Resiklos Gems",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        index == 0
                                            ? "${formatMoney(widget.points)} RP"
                                            : "${formatMoney(widget.count)} RSG",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 38,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),

                                    Visibility(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "= ${formatMoney(widget.exchangeRate * widget.points)} RSG",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      visible: index == 0,
                                    ),

                                    // Container(
                                    //   width: 100,
                                    //   alignment: Alignment.centerLeft,
                                    //   child: Text(
                                    //     "${widget.count} Referrals",
                                    //     style: const TextStyle(
                                    //       color: Colors.white,
                                    //       fontSize: 12,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              flex: 1,
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 70, right: 30),
                                child: index == 0
                                    ? SvgPicture.asset(
                                        "imgs/svg/rp_icon.svg",
                                        width: 52,
                                        height: 52,
                                      )
                                    : Image.asset(
                                        "imgs/logo@2x.png",
                                        width: 52,
                                        height: 52,
                                        fit: BoxFit.cover,
                                      ))
                          ],
                        ),
                      ],
                    ));
              },
            ),
          ),
          Container(
              padding: const EdgeInsets.all(15.0),
              height: 85.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SummaryButtonWidget(
                      text: "Scan QR",
                      icon: 'imgs/svg/scan_icon.svg',
                      click: () {
                        log("123");
                        // showCustomDialog(context);
                      }),
                  SummaryButtonWidget(
                      text: "Transfer",
                      icon: 'imgs/svg/transfer_icon.svg',
                      click: () {
                        log("123456");

                        showTransferBottomSheetWidget(context);
                      }),
                  SummaryButtonWidget(
                      text: "My Vouchers",
                      icon: 'imgs/svg/vouchers_icon.svg',
                      click: () {
                        // EventBusUtil.fire(TabBarChangeEvent(0));
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return MyVouchersPage();
                        }));
                      }),
                  SummaryButtonWidget(
                      text: "Affiliates",
                      icon: 'imgs/svg/affiliates_icon.svg',
                      click: () {
                        log("123456789");

                        NavigatorUtil.push(context, HomeReferrals());
                      }),
                ],
              )),
          // Container(
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 30, top: 20, right: 30),
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: _list.map((e) {
          //           int index = _list.indexOf(e);
          //           return HomeButtonWidget(
          //             model: e,
          //             click: () {
          //               log("click index ${_list.indexOf(e)} value ${e.title}");
          //               if (index == 3) {
          //                 NavigatorUtil.push(context, HomeReferrals());
          //               } else if (index == 0) {
          //                 showCustomDialog(context);
          //               } else if (index == 1) {
          //                 Share.share(
          //                     'check out our website https://resiklos.com',
          //                     subject: 'Look what I made!');
          //               }
          //             },
          //           );
          //         }).toList()),
          //   ),
          // )
        ],
      ),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    log("text ---->>>>>$text  subject ---->>>>>$subject");
    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }
}

class HomeButtonModel {
  IconData url;
  String title;
  Function? click;

  HomeButtonModel(this.url, this.title, this.click);
}
