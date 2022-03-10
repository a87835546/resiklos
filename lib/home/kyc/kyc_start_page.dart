import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/kyc/kyc_frist_page.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';

class KycStartsPage extends BaseStatefulWidget {
  const KycStartsPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _KycStartsPageState();
}

class _KycStartsPageState extends BaseStatefulState<KycStartsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "PERSONAL VERIFICATION",
      ),
      body: Container(
        padding: EdgeInsets.only(left: 60, right: 60),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: 136,
                height: 136,
                child: ClipOval(
                  child: Stack(children: [
                    Container(
                        width: 136,
                        height: 136,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment(-1, 0),
                              end: Alignment(0, -1),
                              colors: [
                                Color.fromRGBO(12, 201, 190, 1),
                                Color.fromRGBO(0, 166, 190, 1)
                              ]),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(136, 136)),
                        )),
                    Container(
                        width: 136,
                        height: 136,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('imgs/verify_kyc_person.png'),
                              fit: BoxFit.contain),
                        ))
                  ]),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: const Text(
                'VERIFY YOUR IDENTITY',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 50),
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum vitae imperdiet cursus mauris.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1),
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
            // Figma Flutter Generator Group196Widget - GROUP
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Container(
                    height: 50,
                    child: const Text(
                      'REQUIREMENTS:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1),
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 55),
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: double.maxFinite,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "imgs/verify_person.png",
                                width: 16,
                                height: 16,
                                color: Color.fromRGBO(212, 212, 212, 1),
                              ),
                              SizedBox(width: 8),
                              const Text(
                                'Personal Information',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(212, 212, 212, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.maxFinite,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "imgs/verify_person.png",
                                width: 16,
                                height: 16,
                                color: Color.fromRGBO(212, 212, 212, 1),
                              ),
                              SizedBox(width: 8),
                              const Text(
                                'Government-issued ID',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(212, 212, 212, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.maxFinite,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "imgs/verify_face_id.png",
                                width: 16,
                                height: 16,
                                color: Color.fromRGBO(212, 212, 212, 1),
                              ),
                              SizedBox(width: 8),
                              const Text(
                                'Facial Recognition',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(212, 212, 212, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ])),
            Expanded(child: Container()),
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
                    "START NOW",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              behavior: HitTestBehavior.translucent,
              onTap: () {
                log("start verify kyc");
                NavigatorUtil.push(context, KycFirstPage());
              },
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
