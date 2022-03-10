import 'dart:developer';

import 'package:adobe_xd/blend_mask.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resiklos/home/home_verify_email_result_page.dart';
import 'package:resiklos/home/home_verify_state_icon.dart';
import 'package:resiklos/home/kyc/kyc_finished_page.dart';
import 'package:resiklos/home/kyc/kyc_second_page.dart';
import 'package:resiklos/home/kyc/kyc_start_page.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/navigator_util.dart';

import 'home_verify_emal_page.dart';

class HomeVerifyView extends StatefulWidget {
  const HomeVerifyView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeVerifyViewState();
}

List<num> _progrcess = [5, 2, 1.2, 1];

class _HomeVerifyViewState extends State<HomeVerifyView> {
  @override
  Widget build(BuildContext context) {
    return _widget(context);
  }
}

Widget _widget(BuildContext context) {
  int index = AppSingleton.userInfoModel?.verifiedEmail == true ? 1 : 0;
  index = AppSingleton.userInfoModel?.verifyId == true ? 2 : index;
  num index1 = _progrcess[index];
  return Stack(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
      ),
      Pinned.fromPins(
        Pin(start: 0.0, end: 0.0),
        Pin(size: 100.0, start: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.987, 1.0),
                  end: Alignment(1.0, 1.0),
                  colors: [
                    Color(0xff00a6be),
                    Color(0xff00a6be),
                    Color(0xff0cc9be)
                  ],
                  stops: [0.0, 0.276, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            Pinned.fromPins(
              Pin(size: 79.0, start: 30.0),
              Pin(size: 79.0, start: 5.0),
              child: BlendMask(
                blendMode: BlendMode.colorDodge,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('imgs/verification_bg_image.png'),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.25), BlendMode.dstIn),
                    ),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment(0.375, -0.512),
              child: SizedBox(
                width: 184.0,
                height: 18.0,
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: Color(0xffffcc5a),
                    ),
                    children: [
                      TextSpan(
                        text: 'ACCOUNT',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ' VERIFICATION',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
              ),
            ),
            Pinned.fromPins(
              Pin(size: 219.0, end: 20.0),
              Pin(size: 37.0, middle: 0.6508),
              child: const Text(
                'Complete account verification to unlock all app features. Link or create your wallet to enable transfers.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 9,
                  color: Color(0xcdffffff),
                  fontWeight: FontWeight.w500,
                  height: 1.3333333333333333,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            ),
          ],
        ),
      ),
      Pinned.fromPins(
        Pin(start: 0.0, end: 0.0),
        Pin(size: 8.0, middle: 0.6757),
        child: Stack(
          children: <Widget>[
            Container(
              color: const Color(0xfff4f4f4),
            ),
            Pinned.fromPins(
              Pin(size: 360.0 / index1, start: 0.0),
              Pin(start: 0.0, end: 0.0),
              child: Container(
                color: const Color(0xff0d90a3),
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        child: Pinned.fromPins(
          Pin(size: 80.0, start: 15.0),
          Pin(size: 61.0, end: 11.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff0d90a3),
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border:
                        Border.all(width: 5.0, color: const Color(0xff00a6be)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, -0.436),
                child: SizedBox(
                  width: 16.0,
                  height: 13.0,
                  child: SvgPicture.string(
                    '<svg viewBox="62.0 155.6 16.0 12.8" ><path transform="translate(59.0, 149.6)" d="M 17.39999771118164 6 L 4.599999904632568 6 C 3.720000267028809 6 3.008000135421753 6.720000267028809 3.008000135421753 7.599999904632568 L 3 17.19999885559082 C 3 18.07999992370605 3.720000267028809 18.79999923706055 4.599999904632568 18.79999923706055 L 17.39999771118164 18.79999923706055 C 18.27999877929688 18.79999923706055 19 18.07999992370605 19 17.19999885559082 L 19 7.599999904632568 C 19 6.720000267028809 18.27999877929688 6 17.39999771118164 6 Z M 17.39999771118164 9.199999809265137 L 10.99999904632568 13.19999980926514 L 4.599999904632568 9.199999809265137 L 4.599999904632568 7.599999904632568 L 10.99999904632568 11.59999942779541 L 17.39999771118164 7.599999904632568 L 17.39999771118164 9.199999809265137 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.344, 0.333),
                child: SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: HomeVerifyStateIcon(
                      type: (AppSingleton.userInfoModel?.verifiedEmail == true
                          ? 3
                          : 2),
                    )),
              ),
              Pinned.fromPins(
                Pin(start: 0.0, end: 0.0),
                Pin(size: 10.0, end: 0.0),
                child: const Text(
                  'VERIFY EMAIL',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 8,
                    color: Color(0xffd4d4d4),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          log("verify email");
          if (AppSingleton.userInfoModel?.verifiedEmail == false) {
            NavigatorUtil.push(context, const HomeVerifyEmail());
          }
        },
      ),
      GestureDetector(
        child: Pinned.fromPins(
          Pin(size: 82.0, middle: 0.5),
          Pin(size: 60.0, end: 11.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f8cc6),
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border:
                        Border.all(width: 5.0, color: const Color(0xfffafafa)),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(start: 0.0, end: 0.0),
                Pin(size: 10.0, end: 0.0),
                child: const Text(
                  'COMPLETE KYC',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 8,
                    color: Color(0xff707070),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment(0.0, -0.417),
                child: SizedBox(
                  width: 15.0,
                  height: 12.0,
                  child: SvgPicture.string(
                    '<svg viewBox="187.3 157.0 15.4 12.0" ><path transform="translate(187.29, 154.75)" d="M 14.14285755157471 2.249999761581421 L 1.285714387893677 2.249999761581421 C 0.5758928656578064 2.249999761581421 0 2.825892686843872 0 3.535714149475098 L 0 12.9642858505249 C 0 13.67410659790039 0.5758928656578064 14.25 1.285714387893677 14.25 L 14.14285755157471 14.25 C 14.8526782989502 14.25 15.4285717010498 13.67410659790039 15.4285717010498 12.9642858505249 L 15.4285717010498 3.535714149475098 C 15.4285717010498 2.825892686843872 14.8526782989502 2.249999761581421 14.14285755157471 2.249999761581421 Z M 4.714285850524902 4.821428775787354 C 5.659821510314941 4.821428775787354 6.428571224212646 5.590178489685059 6.428571224212646 6.535714149475098 C 6.428571224212646 7.481249809265137 5.659821510314941 8.25 4.714285850524902 8.25 C 3.768750190734863 8.25 3 7.481249809265137 3 6.535714149475098 C 3 5.590178489685059 3.768750190734863 4.821428775787354 4.714285850524902 4.821428775787354 Z M 7.714285850524902 11.16428565979004 C 7.714285850524902 11.44821453094482 7.446428775787354 11.67857074737549 7.114285469055176 11.67857074737549 L 2.314285516738892 11.67857074737549 C 1.982142925262451 11.67857074737549 1.714285731315613 11.44821453094482 1.714285731315613 11.16428565979004 L 1.714285731315613 10.64999961853027 C 1.714285731315613 9.798213958740234 2.520535945892334 9.107143402099609 3.514286041259766 9.107143402099609 L 3.64821457862854 9.107143402099609 C 3.977678537368774 9.24375057220459 4.336607456207275 9.321429252624512 4.714285850524902 9.321429252624512 C 5.091964244842529 9.321429252624512 5.453571796417236 9.24375057220459 5.780357360839844 9.107143402099609 L 5.914285659790039 9.107143402099609 C 6.908035278320312 9.107143402099609 7.714285850524902 9.798213958740234 7.714285850524902 10.64999961853027 L 7.714285850524902 11.16428565979004 Z M 13.7142858505249 9.75 C 13.7142858505249 9.867857933044434 13.61785793304443 9.964285850524902 13.5 9.964285850524902 L 9.642857551574707 9.964285850524902 C 9.524999618530273 9.964285850524902 9.428571701049805 9.867857933044434 9.428571701049805 9.75 L 9.428571701049805 9.321429252624512 C 9.428571701049805 9.203571319580078 9.524999618530273 9.107143402099609 9.642857551574707 9.107143402099609 L 13.5 9.107143402099609 C 13.61785793304443 9.107143402099609 13.7142858505249 9.203571319580078 13.7142858505249 9.321429252624512 L 13.7142858505249 9.75 Z M 13.7142858505249 8.035714149475098 C 13.7142858505249 8.153572082519531 13.61785793304443 8.25 13.5 8.25 L 9.642857551574707 8.25 C 9.524999618530273 8.25 9.428571701049805 8.153572082519531 9.428571701049805 8.035714149475098 L 9.428571701049805 7.607142925262451 C 9.428571701049805 7.489285469055176 9.524999618530273 7.392857074737549 9.642857551574707 7.392857074737549 L 13.5 7.392857074737549 C 13.61785793304443 7.392857074737549 13.7142858505249 7.489285469055176 13.7142858505249 7.607142925262451 L 13.7142858505249 8.035714149475098 Z M 13.7142858505249 6.321428298950195 C 13.7142858505249 6.439285755157471 13.61785793304443 6.535714149475098 13.5 6.535714149475098 L 9.642857551574707 6.535714149475098 C 9.524999618530273 6.535714149475098 9.428571701049805 6.439285755157471 9.428571701049805 6.321428298950195 L 9.428571701049805 5.892857074737549 C 9.428571701049805 5.774999618530273 9.524999618530273 5.678571224212646 9.642857551574707 5.678571224212646 L 13.5 5.678571224212646 C 13.61785793304443 5.678571224212646 13.7142858505249 5.774999618530273 13.7142858505249 5.892857074737549 L 13.7142858505249 6.321428298950195 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment(0.333, 0.318),
                child: SizedBox(
                  width: 16.0,
                  height: 16.0,
                  child: HomeVerifyStateIcon(
                    type: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          log("complete kyc");
          NavigatorUtil.push(context, KycStartsPage());
        },
      ),
      GestureDetector(
        child: Pinned.fromPins(
          Pin(size: 80.0, end: 15.0),
          Pin(size: 61.0, end: 11.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffcc5a),
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border:
                        Border.all(width: 5.0, color: const Color(0xfffafafa)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-0.004, -0.429),
                child: SizedBox(
                  width: 14.0,
                  height: 12.0,
                  child: SvgPicture.string(
                    '<svg viewBox="313.0 156.0 13.7 12.0" ><path transform="translate(313.0, 153.75)" d="M 12.35357093811035 4.821429252624512 L 2.142857313156128 4.821429252624512 C 1.906071305274963 4.821429252624512 1.714285850524902 4.629642963409424 1.714285850524902 4.392857074737549 C 1.714285850524902 4.156071662902832 1.906071305274963 3.964286088943481 2.142857313156128 3.964286088943481 L 12.42857074737549 3.964286088943481 C 12.66535758972168 3.964286088943481 12.85714149475098 3.772500276565552 12.85714149475098 3.535714864730835 C 12.85714149475098 2.825625419616699 12.28151607513428 2.250000238418579 11.57142734527588 2.250000238418579 L 1.714285850524902 2.250000238418579 C 0.7674106359481812 2.250000238418579 0 3.017410755157471 0 3.964286088943481 L 0 12.53571510314941 C 0 13.482590675354 0.7674106359481812 14.25000095367432 1.714285850524902 14.25000095367432 L 12.35357093811035 14.25000095367432 C 13.10410690307617 14.25000095367432 13.71428680419922 13.67330455780029 13.71428680419922 12.96428775787354 L 13.71428680419922 6.107142925262451 C 13.71428680419922 5.398125171661377 13.10410690307617 4.821429252624512 12.35357093811035 4.821429252624512 Z M 11.14285755157471 10.39285945892334 C 10.66955280303955 10.39285945892334 10.28571224212646 10.00901889801025 10.28571224212646 9.535715103149414 C 10.28571224212646 9.062411308288574 10.66955280303955 8.678573608398438 11.14285755157471 8.678573608398438 C 11.61616134643555 8.678573608398438 11.99999809265137 9.062411308288574 11.99999809265137 9.535715103149414 C 11.99999809265137 10.00901889801025 11.61616134643555 10.39285945892334 11.14285755157471 10.39285945892334 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(start: 0.0, end: 0.0),
                Pin(size: 10.0, end: 0.0),
                child: const Text(
                  'SET WALLET',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 8,
                    color: Color(0xff707070),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Align(
                alignment: Alignment(0.344, 0.333),
                child: SizedBox(
                  width: 16.0,
                  height: 16.0,
                  child: HomeVerifyStateIcon(
                    type: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          log("set wallet");

          NavigatorUtil.push(context, KYCFinishedPage());
        },
      ),
    ],
  );
}

enum VerifyState {
  incomplete,
  pending,
  complete,
}
