import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/home_verify_email_result_page.dart';
import 'package:resiklos/home/setting/setting_request.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';

class HomeVerifyEmail extends BaseStatefulWidget {
  const HomeVerifyEmail({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _HomeVerifyEmail();
}

class _HomeVerifyEmail extends BaseStatefulState<HomeVerifyEmail> {
  final List<TextEditingController> _list = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final List<FocusNode> _nodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  @override
  void initState() {
    super.initState();
    getEmailOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
      ),
      body: _widget(context),
    );
  }

  Widget _widget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 390.0,
          color: const Color(0xffffffff),
        ),
        Transform.translate(
          offset: Offset(45.0, 534.0),
          child: SizedBox(
            width: 300.0,
            height: 50.0,
            child: GestureDetector(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 300.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: const Color(0xff00a6be),
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(39.0, 16.0),
                    child: const SizedBox(
                      width: 222.0,
                      child: Text(
                        'VERIFY & PROCEED',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: false,
                      ),
                    ),
                  ),
                ],
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                log("verify");
                String value = "";
                _list.forEach((element) {
                  value += element.text;
                });
                var result = await verifyEmail(value);
                if (result == true) {
                  NavigatorUtil.push(context, HomeVerifyEmailResultPage());
                }
              },
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(73.0, 409.0),
          child: SizedBox(
            width: 245.0,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [0, 1, 2, 3].map((e) {
                FocusNode node = _nodes[e];
                TextEditingController _controller = _list[e];
                return Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(5.0),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                  child: TextField(
                    focusNode: node,
                    controller: _controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: mainColor()),
                      // contentPadding: EdgeInsets.only(left: 21),
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      if (e < 3) {
                        if (v.length == 1) {
                          node.unfocus();
                          FocusNode next = _nodes[e + 1];
                          FocusScope.of(context).requestFocus(next); // 获取焦点
                        }
                      } else {
                        node.unfocus();
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(49.5, 484.0),
          child: SizedBox(
            width: 291.0,
            height: 30,
            child: GestureDetector(
              child: const Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Color(0xff707070),
                  ),
                  children: [
                    TextSpan(
                      text: 'Didn’t receive the OTP? ',
                    ),
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        color: Color(0xffff9d00),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                log("resend");
                getEmailOtp();
              },
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(45.0, 374.0),
          child: SizedBox(
            width: 300.0,
            height: 17.0,
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  color: Color(0xff707070),
                ),
                children: [
                  const TextSpan(
                    text: 'Enter the OTP sent to ',
                  ),
                  TextSpan(
                    text: '${AppSingleton.userInfoModel?.email}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              textHeightBehavior:
                  const TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(45.0, 309.0),
          child: const SizedBox(
            width: 300.0,
            height: 35.0,
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  color: Color(0xff707070),
                ),
                children: [
                  TextSpan(
                    text: 'We have sent a ',
                  ),
                  TextSpan(
                    text: 'One Time Password (OTP)\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'to your registered email address.',
                  ),
                ],
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(50.0, 19.4),
          child: SizedBox(
            width: 289.0,
            height: 275.0,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: 289.0,
                  height: 235.0,
                  child: SvgPicture.string(
                    '<svg viewBox="50.0 126.4 289.4 234.8" ><path transform="translate(-4582.45, -36.0)" d="M 4715.54296875 224.744384765625 C 4670.39111328125 225.9883728027344 4636.20947265625 289.279296875 4636.20947265625 289.279296875 C 4636.20947265625 289.279296875 4597.02978515625 440.9065551757812 4771.66455078125 384.7824096679688 C 4826.166015625 369.9018859863281 4848.64208984375 355.5657653808594 4863.3203125 323.492919921875 C 4998.4521484375 257.6325073242188 4865.08642578125 125.8401870727539 4806.19140625 175.4161376953125 C 4693.97998046875 128.2154846191406 4715.54296875 224.744384765625 4715.54296875 224.744384765625 Z" fill="#f2fdff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(45.0, 20.6),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('imgs/verify_email_image.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(32.5, 252.6),
                  child: const SizedBox(
                    width: 226.0,
                    child: Text(
                      'Verify Your Email',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        color: Color(0xff00a6be),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
