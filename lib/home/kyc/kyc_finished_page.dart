import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/bottom_navigationbar.dart';
import 'package:resiklos/sign_up_in/sign_logo_page.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';

class KYCFinishedPage extends StatefulWidget {
  const KYCFinishedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KYCFinishedPageState();
}

class _KYCFinishedPageState extends State<KYCFinishedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: Container()),
                Container(
                  height: 500,
                  padding: EdgeInsets.only(left: 40, top: 80, right: 40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          child: const Text(
                            'IDENTITY VERIFICATION SENT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ),
                      ),
                      Container(
                        child: const Text(
                            "Your KYC Request has been submitted for approval. KYC results may take up to 24 hours. ",
                            style: TextStyle(
                              color: Color(0xff707070),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                            "For questions and other concerns, please email info@resiklos.com.",
                            style: TextStyle(
                              color: Color(0xffd4d4d4),
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: const Text(
                            "KYC REQUEST \n REF. NO. 01234 567 890123",
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: const Text(
                          "March 03 2022, 10:42 PM",
                          style: TextStyle(
                            color: Color(0xffd4d4d4),
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        child: Container(
                            decoration: BoxDecoration(
                              color: mainColor(),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            width: 232,
                            height: 50,
                            child: const Text(
                              "CONTINUE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          log("next");
                          Navigator.pushAndRemoveUntil(context,
                              PageRouteBuilder(pageBuilder:
                                  (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                            return CustomBottomNavigationBar();
                          }), (route) => false);
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              child: SignLogoPage(
                url: "imgs/img.png",
              ),
              left: (MediaQuery.of(context).size.width - 100) / 2,
              top: MediaQuery.of(context).size.height -
                  500 -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  20,
            ),
          ],
        ),
      ),
    );
  }
}
