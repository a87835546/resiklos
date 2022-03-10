import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/kyc/kyc_progress_widget.dart';
import 'package:resiklos/home/kyc/kyc_second_two_page.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';

/// @author :create by yicen
/// date: ${DATE}$
/// email: a87835546@gmail.com
/// desc:

class KycSecondPage extends BaseStatefulWidget {
  const KycSecondPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _KycSecondPageState();
}

class _KycSecondPageState extends BaseStatefulState<KycSecondPage> {
  var _select = "Government-issued ID";
  final List<String> _list = ["Government-issued ID","Driver’s License","Passport","Others (School ID, Company ID)"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "PERSONAL VERIFICATION",
      ),
      body:Stack(
        children: [
          KYCProgressWidget(type: 2,),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Personal Information',
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
                  width: double.maxFinite,
                  child: const Text(
                    "Use a valid issued ID",
                    style: TextStyle(color: Color(0xff707070), fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    style: TextStyle(color: Color(0xffd4d4d4), fontSize: 12),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40, bottom: 5),
                  alignment: Alignment.centerLeft,
                  width: double.maxFinite,
                  child: const Text(
                    "Choose type of ID",
                    style: TextStyle(color: Color(0xff707070), fontSize: 12),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: _list.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color:
                                _select == e ? mainColor() : Color(0xffBFBFBF),
                              ),
                              borderRadius: BorderRadius.circular(25)),
                          height: 50,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              _select == e ? _selectedIcon() : _icon(),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.today_sharp,
                                size: 14,
                                color:
                                _select == e ? mainColor() : Color(0xff707070),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        color: _select == e
                                            ? mainColor()
                                            : Color(0xffBFBFBF)),
                                  )),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _select = e;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
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
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    log("next");
                    NavigatorUtil.push(context, KycSecond2Page(type: _list.indexOf(_select),));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _icon() {
    return Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(
            color: Color.fromRGBO(191, 191, 191, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.elliptical(16, 16)),
        ));
  }

  Widget _selectedIcon() {
    return Container(
        width: 16,
        height: 16,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(
                      color: const Color.fromRGBO(0, 166, 190, 1),
                      width: 1,
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(16, 16)),
                  ))),
          Positioned(
              top: 3,
              left: 3,
              child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 166, 190, 1),
                    borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                  ))),
        ]));
  }
}
