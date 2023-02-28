import 'dart:developer';

import 'package:adobe_xd/page_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/bottom_navigationbar.dart';
import 'package:resiklos/utils/event_bus_util.dart';

class HomeVerifyEmailResultPage extends BaseStatefulWidget {
  const HomeVerifyEmailResultPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() =>
      _HomeVerifyEmailResultPage();
}

class _HomeVerifyEmailResultPage
    extends BaseStatefulState<HomeVerifyEmailResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Stack(
            children: [
              Container(
                width: 390.0,
                color: const Color(0xffffffff),
              ),
              Transform.translate(
                offset: Offset(45.0, 384.2),
                child: SizedBox(
                  width: 300.0,
                  height: 50.0,
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
                        offset: Offset(42.5, 16.0),
                        child: const SizedBox(
                          width: 215.0,
                          child: Text(
                            'PROCEED TO KYC',
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
                      Transform.translate(
                        offset: Offset(268.0, 15.1),
                        child: SizedBox(
                          width: 12.0,
                          height: 20.0,
                          child: SvgPicture.string(
                            '<svg viewBox="342.0 589.1 12.0 19.8" ><path transform="translate(340.07, 586.47)" d="M 13.61493015289307 13.30307674407959 L 4.814791679382324 22.10317039489746 C 4.39037036895752 22.52759170532227 3.702276945114136 22.52759170532227 3.277901172637939 22.10317039489746 L 2.251511096954346 21.07678031921387 C 1.82781445980072 20.65308380126953 1.826999425888062 19.96639251708984 2.249699831008911 19.54170227050781 L 9.223963737487793 12.53460788726807 L 2.249699831008911 5.527560710906982 C 1.826999425888062 5.102867603302002 1.82781445980072 4.416177272796631 2.251510858535767 3.992480993270874 L 3.277901172637939 2.966091156005859 C 3.702322244644165 2.541670083999634 4.390415668487549 2.541670083999634 4.814791679382324 2.966091156005859 L 13.6148853302002 11.76618576049805 C 14.03930568695068 12.19056129455566 14.03930568695068 12.8786563873291 13.61493015289307 13.30307674407959 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                    padding: EdgeInsets.only(left: 71, top: 482),
                    child: Container(
                      height: 30,
                      child: const SizedBox(
                        width: 248.0,
                        child: Text(
                          'I will do it later',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Color(0xff00a6be),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: false,
                        ),
                      ),
                    )),
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  EventBusUtil.fire(RefreshDashboardEvent());
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (ctx) {
                    return CustomBottomNavigationBar();
                  }), (route) => false);
                },
              ),
              Transform.translate(
                offset: Offset(45.0, 316.2),
                child: const SizedBox(
                  width: 300.0,
                  height: 43.0,
                  child: Text(
                    'Your email address has been verified. You may now proceed to the next step.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: Color(0xff707070),
                      height: 1.6666666666666667,
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
                  height: 235.0,
                  child: SvgPicture.string(
                    '<svg viewBox="50.0 171.2 289.4 234.8" ><path transform="translate(-4582.45, 8.75)" d="M 4715.54296875 224.744384765625 C 4670.39111328125 225.9883728027344 4636.20947265625 289.279296875 4636.20947265625 289.279296875 C 4636.20947265625 289.279296875 4597.02978515625 440.9065551757812 4771.66455078125 384.7824096679688 C 4826.166015625 369.9018859863281 4848.64208984375 355.5657653808594 4863.3203125 323.492919921875 C 4998.4521484375 257.6325073242188 4865.08642578125 125.8401870727539 4806.19140625 175.4161376953125 C 4693.97998046875 128.2154846191406 4715.54296875 224.744384765625 4715.54296875 224.744384765625 Z" fill="#fcfff2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(95.0, 40.0),
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('imgs/verify_success_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(34.5, 279.2),
                child: const SizedBox(
                  width: 323.0,
                  child: Text(
                    'Email Verification Success!',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      color: Color(0xff707070),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(94.0, 449.2),
                child: const SizedBox(
                  width: 202.0,
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: Color(0xffd4d4d4),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(50.3, 76.4),
                child: SizedBox(
                  width: 294.0,
                  height: 153.0,
                  child: SvgPicture.string(
                    '<svg viewBox="50.3 228.2 293.8 152.6" ><path transform="matrix(0.898794, -0.438371, 0.438371, 0.898794, 44.97, 350.95)" d="M 35.19979095458984 6.000000953674316 L 6.577754497528076 6.000000953674316 C 4.609989643096924 6.000000953674316 3.017889022827148 7.609991073608398 3.017889022827148 9.577755928039551 L 3 31.04428863525391 C 3 33.01205444335938 4.609989643096924 34.62203979492188 6.577754497528076 34.62203979492188 L 35.19979095458984 34.62203979492188 C 37.16755294799805 34.62203979492188 38.77754974365234 33.01205444335938 38.77754974365234 31.04428863525391 L 38.77754974365234 9.577755928039551 C 38.77754974365234 7.609991073608398 37.16755294799805 6.000000953674316 35.19979095458984 6.000000953674316 Z M 35.19979095458984 13.15551090240479 L 20.88877105712891 22.09990119934082 L 6.577754497528076 13.15551090240479 L 6.577754497528076 9.577755928039551 L 20.88877105712891 18.52214241027832 L 35.19979095458984 9.577755928039551 L 35.19979095458984 13.15551090240479 Z" fill="#75be00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.965926, 0.258819, -0.258819, 0.965926, 302.33, 221.61)" d="M 40.70766067504883 5.999999523162842 L 7.189740180969238 5.999999523162842 C 4.885383605957031 5.999999523162842 3.020948886871338 7.885384082794189 3.020948886871338 10.18974113464355 L 3 35.32818222045898 C 3 37.63253784179688 4.885383605957031 39.51792144775391 7.189740180969238 39.51792144775391 L 40.70766067504883 39.51792144775391 C 43.01201629638672 39.51792144775391 44.89740371704102 37.63253784179688 44.89740371704102 35.32818222045898 L 44.89740371704102 10.18974113464355 C 44.89740371704102 7.885384082794189 43.01201629638672 5.999999523162842 40.70766067504883 5.999999523162842 Z M 40.70766067504883 14.37948226928711 L 23.94870185852051 24.85383415222168 L 7.189740180969238 14.37948226928711 L 7.189740180969238 10.18974113464355 L 23.94870185852051 20.66409301757812 L 40.70766067504883 10.18974113464355 L 40.70766067504883 14.37948226928711 Z" fill="#abda61" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
