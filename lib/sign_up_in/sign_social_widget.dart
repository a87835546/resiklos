import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/sign_up_in/sign_request.dart';
import 'package:resiklos/utils/navigator_util.dart';

import '../bottom_navigationbar.dart';

class SocialSignPage extends StatefulWidget {
  const SocialSignPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SocialSignPageState();
}

class _SocialSignPageState extends State<SocialSignPage> {
  final List<String> _images = [
    "imgs/facebook@2x.png",
    "imgs/google@2x.png",
    // "imgs/instagram@2x.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            "or Sign In via",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xffD4D4D4),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _images.map((e) {
                return GestureDetector(
                  onTap: () async {
                    int index = _images.indexOf(e);
                    log("index -->>>> $index");
                    if (index == 0) {
                      var r = await SignRequest.onPressedLogInButton();
                      if (r == true) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) {
                          return CustomBottomNavigationBar();
                        }), (route) => false);
                      }
                    } else if (index == 1) {
                      var r = await SignRequest.handleSignIn();
                      if (r == true) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) {
                          return CustomBottomNavigationBar();
                        }), (route) => false);
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        e,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                );
              }).toList()),
        )
      ],
    );
  }
}
