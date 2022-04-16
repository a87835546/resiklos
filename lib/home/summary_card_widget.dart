import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resiklos/home/home_referrals_page.dart';
import 'package:resiklos/home/qr_code_dailog.dart';
import 'package:resiklos/home/summary_button_widget.dart';
import 'package:resiklos/utils/event_bus_util.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/wallet/transfer_bottom_sheet_widget.dart';

Widget SummaryCardWidget(BuildContext context,
    {num amount = 0, int affiliatesCount = 0}) {
  return Container(
    // padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          height: 243.0,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Container(
              padding: const EdgeInsets.all(5.0),
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
                        showCustomDialog(context);
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
                        EventBusUtil.fire(TabBarChangeEvent(0));
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
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 156.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(1.132, -1.192),
                  end: Alignment(-1.0, 1.0),
                  colors: [Color(0xff00f5d9), Color(0xff00a6be)],
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                boxShadow: [
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
                width: 321.0,
                height: 156.0,
                child: SvgPicture.asset('imgs/svg/summary_bg.svg',
                    allowDrawingOutsideViewBox: true, height: double.infinity),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(right: 25),
              child: Transform.translate(
                offset: const Offset(0, -21),
                child: Container(
                  width: 133,
                  height: 127.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('imgs/logo@2x.png'),
                        fit: BoxFit.contain,
                        alignment: Alignment.topRight),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(35.0, 20.0, 35.0, 0),
              width: double.infinity,
              height: 156.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$amount",
                    style: const TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    'RSG',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    softWrap: false,
                  ),
                  const Text(
                    'Resiklos Gems',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: false,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/affiliates');
                    },
                    child: SizedBox(
                      width: 81.0,
                      height: 15.0,
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xffffffff),
                          ),
                          children: [
                            TextSpan(
                              text: affiliatesCount.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(
                              text: ' Affiliates',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}
