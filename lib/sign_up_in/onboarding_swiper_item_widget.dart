import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'onboarding_page.dart';

class OnboardingSwiperItemWidget extends StatelessWidget {
  final SwiperModel model;

  const OnboardingSwiperItemWidget({Key? key, required this.model})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              model.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          kIsWeb
              ? Padding(
                  padding:
                      EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 15),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: 1,
                      color: Colors.white54,
                    )
                  ))
              : Padding(
                  padding:
                      EdgeInsets.only(top: 15, left: 80, right: 80, bottom: 15),
                  child: Container(
                    child: const Divider(
                      color: Colors.white54,
                      height: 1,
                    ),
                  )),
          Container(
            margin: EdgeInsets.only(left: 70, right: 70),
            alignment: Alignment.center,
            child: Text(
              model.desc,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          )
        ],
      ),
    );
  }
}
