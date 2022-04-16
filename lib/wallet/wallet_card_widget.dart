import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resiklos/wallet/show_toast.dart';

Widget walletCardWidget(BuildContext context,
        {required dynamic asset, required String address}) =>
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 360.0,
        height: 180.0,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 180.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(1.498, -0.675),
                  end: Alignment(-0.974, 0.973),
                  colors: [Color(0xffd4d4d4), Color(0xff00a6be)],
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.circular(15.0),
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
              child: SizedBox(
                height: 180.0,
                child: SvgPicture.asset(
                  'imgs/svg/wallet_bg.svg',
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 73.0,
              child: Stack(
                children: <Widget>[
                  SizedBox.expand(
                    child: SvgPicture.asset(
                      'imgs/svg/wallet_header.svg',
                      allowDrawingOutsideViewBox: true,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 25),
                    child: asset.type == 'svg'
                        ? SvgPicture.asset(asset.icon, width: 50, height: 50)
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: Image.asset(
                              asset.icon,
                            ),
                          ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    width: 121.0,
                    height: 18.0,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: address))
                                .then((_) {
                              showToast(context, 'Wallet address copied');
                            });
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        '${address.substring(0, 5)}…${address.substring(address.length - 4)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    )),
                                const WidgetSpan(
                                  child: SizedBox(
                                      width: 24,
                                      height: 18,
                                      child: Icon(
                                        Icons.content_copy_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      )),
                                  alignment: PlaceholderAlignment.bottom,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 18.0,
                          height: 18.0,
                          child: SvgPicture.asset(
                            'imgs/svg/external_link.svg',
                            fit: BoxFit.none,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(20.0, 12.0),
                    child: SizedBox(
                      width: 104.0,
                      height: 29.0,
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            width: 104.0,
                            height: 16.0,
                            child: Text(
                              '${asset.coin} Wallet',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0.0, 16.0),
                            child: SizedBox(
                              width: 77.0,
                              height: 13.0,
                              child: Text(
                                asset.name,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0x89ffffff),
                                  fontWeight: FontWeight.w700,
                                ),
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
            Container(
              margin: const EdgeInsets.only(top: 86),
              width: 320.0,
              height: 64.0,
              child: Stack(
                children: <Widget>[
                  Visibility(
                    child: Transform.translate(
                      offset: const Offset(0.0, 45.0),
                      child: const SizedBox(
                        width: 320.0,
                        height: 19.0,
                        child: Text(
                          'BEP-20',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0x99ffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    visible: true,
                  ),
                  SizedBox(
                    width: 320.0,
                    height: 42.0,
                    child: Text(
                      '${asset.amount} ${asset.coin}',
                      style: const TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
