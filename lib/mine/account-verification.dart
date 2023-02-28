import 'package:adobe_xd/blend_mask.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MineVerificationWidget extends StatefulWidget {
  const MineVerificationWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineVerificationState();
}

class _MineVerificationState extends State<MineVerificationWidget> {
  bool is_fully_verified = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(250.0, 0.0),
              child: SizedBox(
                width: 85.0,
                height: 61.0,
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(22.0, 0.0),
                      child: SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: getAccountStatusWidget(),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, 51.0),
                      child: const SizedBox(
                        width: 85.0,
                        height: 10.0,
                        child: Text(
                          'FULLY VERIFIED',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 8,
                            color: Color(0xffd4d4d4),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(125.0, 1.0),
              child: SizedBox(
                width: 85.0,
                height: 60.0,
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(22.0, 0.0),
                      child: SizedBox(
                        width: 40.0,
                        height: 45.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: const Color(0xffffcc5a),
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(9999.0, 9999.0)),
                                border: Border.all(
                                    width: 5.0, color: const Color(0xfff4f4f4)),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(12.3, 14.0),
                              child: SizedBox(
                                width: 15.0,
                                height: 12.0,
                                child: SvgPicture.string(
                                  '<svg viewBox="187.3 220.0 15.4 12.0" ><path transform="translate(187.29, 217.75)" d="M 14.14285755157471 2.249999761581421 L 1.285714387893677 2.249999761581421 C 0.5758928656578064 2.249999761581421 0 2.825892686843872 0 3.535714149475098 L 0 12.9642858505249 C 0 13.67410659790039 0.5758928656578064 14.25 1.285714387893677 14.25 L 14.14285755157471 14.25 C 14.8526782989502 14.25 15.4285717010498 13.67410659790039 15.4285717010498 12.9642858505249 L 15.4285717010498 3.535714149475098 C 15.4285717010498 2.825892686843872 14.8526782989502 2.249999761581421 14.14285755157471 2.249999761581421 Z M 4.714285850524902 4.821428775787354 C 5.659821510314941 4.821428775787354 6.428571224212646 5.590178489685059 6.428571224212646 6.535714149475098 C 6.428571224212646 7.481249809265137 5.659821510314941 8.25 4.714285850524902 8.25 C 3.768750190734863 8.25 3 7.481249809265137 3 6.535714149475098 C 3 5.590178489685059 3.768750190734863 4.821428775787354 4.714285850524902 4.821428775787354 Z M 7.714285850524902 11.16428565979004 C 7.714285850524902 11.44821453094482 7.446428775787354 11.67857074737549 7.114285469055176 11.67857074737549 L 2.314285516738892 11.67857074737549 C 1.982142925262451 11.67857074737549 1.714285731315613 11.44821453094482 1.714285731315613 11.16428565979004 L 1.714285731315613 10.64999961853027 C 1.714285731315613 9.798213958740234 2.520535945892334 9.107143402099609 3.514286041259766 9.107143402099609 L 3.64821457862854 9.107143402099609 C 3.977678537368774 9.24375057220459 4.336607456207275 9.321429252624512 4.714285850524902 9.321429252624512 C 5.091964244842529 9.321429252624512 5.453571796417236 9.24375057220459 5.780357360839844 9.107143402099609 L 5.914285659790039 9.107143402099609 C 6.908035278320312 9.107143402099609 7.714285850524902 9.798213958740234 7.714285850524902 10.64999961853027 L 7.714285850524902 11.16428565979004 Z M 13.7142858505249 9.75 C 13.7142858505249 9.867857933044434 13.61785793304443 9.964285850524902 13.5 9.964285850524902 L 9.642857551574707 9.964285850524902 C 9.524999618530273 9.964285850524902 9.428571701049805 9.867857933044434 9.428571701049805 9.75 L 9.428571701049805 9.321429252624512 C 9.428571701049805 9.203571319580078 9.524999618530273 9.107143402099609 9.642857551574707 9.107143402099609 L 13.5 9.107143402099609 C 13.61785793304443 9.107143402099609 13.7142858505249 9.203571319580078 13.7142858505249 9.321429252624512 L 13.7142858505249 9.75 Z M 13.7142858505249 8.035714149475098 C 13.7142858505249 8.153572082519531 13.61785793304443 8.25 13.5 8.25 L 9.642857551574707 8.25 C 9.524999618530273 8.25 9.428571701049805 8.153572082519531 9.428571701049805 8.035714149475098 L 9.428571701049805 7.607142925262451 C 9.428571701049805 7.489285469055176 9.524999618530273 7.392857074737549 9.642857551574707 7.392857074737549 L 13.5 7.392857074737549 C 13.61785793304443 7.392857074737549 13.7142858505249 7.489285469055176 13.7142858505249 7.607142925262451 L 13.7142858505249 8.035714149475098 Z M 13.7142858505249 6.321428298950195 C 13.7142858505249 6.439285755157471 13.61785793304443 6.535714149475098 13.5 6.535714149475098 L 9.642857551574707 6.535714149475098 C 9.524999618530273 6.535714149475098 9.428571701049805 6.439285755157471 9.428571701049805 6.321428298950195 L 9.428571701049805 5.892857074737549 C 9.428571701049805 5.774999618530273 9.524999618530273 5.678571224212646 9.642857551574707 5.678571224212646 L 13.5 5.678571224212646 C 13.61785793304443 5.678571224212646 13.7142858505249 5.774999618530273 13.7142858505249 5.892857074737549 L 13.7142858505249 6.321428298950195 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                  allowDrawingOutsideViewBox: true,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(23.0, 29.0),
                              child: SizedBox(
                                width: 16.0,
                                height: 16.0,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 16.0,
                                      height: 16.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        borderRadius: const BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        border: Border.all(
                                            width: 2.0,
                                            color: const Color(0xffffffff)),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(2.0, 2.0),
                                      child: SizedBox(
                                        width: 12.0,
                                        height: 12.0,
                                        child: SvgPicture.string(
                                          '<svg viewBox="200.0 237.0 12.0 12.0" ><path transform="translate(199.44, 236.44)" d="M 12.5625 6.5625 C 12.5625 9.876944541931152 9.875975608825684 12.5625 6.5625 12.5625 C 3.249024152755737 12.5625 0.5625 9.876943588256836 0.5625 6.5625 C 0.5625 3.249991655349731 3.249024152755737 0.5625 6.5625 0.5625 C 9.875975608825684 0.5625 12.5625 3.24999213218689 12.5625 6.5625 Z M 6.5625 7.772177696228027 C 5.947863101959229 7.772177696228027 5.449596881866455 8.270442962646484 5.449596881866455 8.88508129119873 C 5.449596881866455 9.499717712402344 5.947863101959229 9.997983932495117 6.5625 9.997983932495117 C 7.17713737487793 9.997983932495117 7.675403594970703 9.499717712402344 7.675403594970703 8.88508129119873 C 7.675403594970703 8.270442962646484 7.17713737487793 7.772177696228027 6.5625 7.772177696228027 Z M 5.505895137786865 3.771870851516724 L 5.685362815856934 7.062193870544434 C 5.693758487701416 7.216161727905273 5.821064472198486 7.33669376373291 5.975250244140625 7.33669376373291 L 7.149750232696533 7.33669376373291 C 7.303935527801514 7.33669376373291 7.4312424659729 7.216161727905273 7.439637184143066 7.062193870544434 L 7.619104862213135 3.771870851516724 C 7.628177165985107 3.605564594268799 7.495765686035156 3.465725660324097 7.329217910766602 3.465725660324097 L 5.795758247375488 3.465725660324097 C 5.629209518432617 3.465725660324097 5.496822834014893 3.605564594268799 5.505895137786865 3.771870851516724 Z" fill="#ff9d00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                          allowDrawingOutsideViewBox: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, 50.0),
                      child: const SizedBox(
                        width: 85.0,
                        height: 10.0,
                        child: Text(
                          'CONFIRM IDENTITY',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 8,
                            color: Color(0xffd4d4d4),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 85.0,
              height: 61.0,
              child: PageLink(
                links: [
                  PageLinkInfo(
                    transition: LinkTransition.SlideUp,
                    ease: Curves.easeInOut,
                    duration: 0.4,
                    pageBuilder: () => Container(),
                  ),
                ],
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: const Alignment(-0.022, -1.0),
                      child: SizedBox(
                        width: 40.0,
                        height: 46.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff0d90a3),
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(9999.0, 9999.0)),
                                border: Border.all(
                                    width: 5.0, color: const Color(0xff00a6be)),
                              ),
                              margin:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 6.0),
                            ),
                            Transform.translate(
                              offset: const Offset(12.0, 13.6),
                              child: SizedBox(
                                width: 16.0,
                                height: 13.0,
                                child: SvgPicture.string(
                                  '<svg viewBox="62.0 155.6 16.0 12.8" ><path transform="translate(59.0, 149.6)" d="M 17.39999771118164 6 L 4.599999904632568 6 C 3.720000267028809 6 3.008000135421753 6.720000267028809 3.008000135421753 7.599999904632568 L 3 17.19999885559082 C 3 18.07999992370605 3.720000267028809 18.79999923706055 4.599999904632568 18.79999923706055 L 17.39999771118164 18.79999923706055 C 18.27999877929688 18.79999923706055 19 18.07999992370605 19 17.19999885559082 L 19 7.599999904632568 C 19 6.720000267028809 18.27999877929688 6 17.39999771118164 6 Z M 17.39999771118164 9.199999809265137 L 10.99999904632568 13.19999980926514 L 4.599999904632568 9.199999809265137 L 4.599999904632568 7.599999904632568 L 10.99999904632568 11.59999942779541 L 17.39999771118164 7.599999904632568 L 17.39999771118164 9.199999809265137 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                  allowDrawingOutsideViewBox: true,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(23.0, 30.0),
                              child: SizedBox(
                                width: 16.0,
                                height: 16.0,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 16.0,
                                      height: 16.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        borderRadius: const BorderRadius.all(
                                            Radius.elliptical(9999.0, 9999.0)),
                                        border: Border.all(
                                            width: 2.0,
                                            color: const Color(0xffffffff)),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset(2.0, 2.0),
                                      child: SizedBox(
                                        width: 12.0,
                                        height: 12.0,
                                        child: SvgPicture.string(
                                          '<svg viewBox="75.0 174.0 12.0 12.0" ><path transform="translate(72.0, 171.0)" d="M 8.999999046325684 3 C 5.687999725341797 3 3 5.687999725341797 3 8.999999046325684 C 3 12.31199932098389 5.687999248504639 15 8.999999046325684 15 C 12.31199932098389 15 15 12.31199932098389 15 8.999999046325684 C 15 5.687999248504639 12.31199932098389 3 8.999999046325684 3 Z M 7.799999237060547 11.99999809265137 L 4.799998760223389 8.999999046325684 L 5.645998954772949 8.153999328613281 L 7.799999237060547 10.30200004577637 L 12.35399913787842 5.747998714447021 L 13.19999980926514 6.599998950958252 L 7.799999237060547 11.99999809265137 Z" fill="#75be00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                          allowDrawingOutsideViewBox: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, 51.0),
                      child: const SizedBox(
                        width: 85.0,
                        height: 10.0,
                        child: Text(
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
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.007, -0.328),
              child: SizedBox(
                width: 199.0,
                height: 0.0,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 199.0,
                      height: 1.0,
                      child: SvgPicture.string(
                        '<svg viewBox="95.5 225.5 199.0 1.0" ><path transform="translate(220.5, 225.5)" d="M 0 0 L 74 0" fill="none" stroke="#d4d4d4" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(95.5, 225.5)" d="M 0 0 L 74 0" fill="none" stroke="#00a6be" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )

// Widgets

        );
  }

  Widget getAccountStatusWidget() {
    // check if user is fully verified
    if (is_fully_verified) {
      return Stack(
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius:
                  const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
              border: Border.all(width: 5.0, color: const Color(0xff75be00)),
            ),
          ),
          Transform.translate(
            offset: Offset(9.0, 9.0),
            child: SizedBox(
              width: 22.0,
              height: 22.0,
              child: SvgPicture.string(
                '<svg viewBox="309.0 151.0 22.0 22.0" ><path transform="translate(306.0, 148.0)" d="M 14 3 C 7.928000926971436 3 3 7.928000926971436 3 14 C 3 20.07200050354004 7.927999973297119 25.00000190734863 14 25.00000190734863 C 20.07200241088867 25.00000190734863 25.00000190734863 20.07200241088867 25.00000190734863 14 C 25.00000190734863 7.927999973297119 20.07200241088867 3 14 3 Z M 11.80000019073486 19.50000190734863 L 6.300000667572021 14 L 7.851000308990479 12.44900035858154 L 11.80000019073486 16.38700103759766 L 20.14900016784668 8.037998199462891 L 21.70000267028809 9.600000381469727 L 11.80000019073486 19.50000190734863 Z" fill="#75be00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
        ],
      );
    } else {
      return BlendMask(
        blendMode: BlendMode.luminosity,
        region: Offset(300.0, 142.0) & Size(40.0, 40.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color(0x40ffffff),
                borderRadius:
                    const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                border: Border.all(width: 5.0, color: const Color(0x4075be00)),
              ),
            ),
            Transform.translate(
              offset: const Offset(9.0, 9.0),
              child: SizedBox(
                width: 22.0,
                height: 22.0,
                child: SvgPicture.string(
                  '<svg viewBox="309.0 151.0 22.0 22.0" ><path transform="translate(306.0, 148.0)" d="M 14 3 C 7.928000926971436 3 3 7.928000926971436 3 14 C 3 20.07200050354004 7.927999973297119 25.00000190734863 14 25.00000190734863 C 20.07200241088867 25.00000190734863 25.00000190734863 20.07200241088867 25.00000190734863 14 C 25.00000190734863 7.927999973297119 20.07200241088867 3 14 3 Z M 11.80000019073486 19.50000190734863 L 6.300000667572021 14 L 7.851000308990479 12.44900035858154 L 11.80000019073486 16.38700103759766 L 20.14900016784668 8.037998199462891 L 21.70000267028809 9.600000381469727 L 11.80000019073486 19.50000190734863 Z" fill="#75be00" fill-opacity="0.25" stroke="none" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
