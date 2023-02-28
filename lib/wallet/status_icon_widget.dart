import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/constants.dart';

Widget StatusIconWidget(
    {String title = 'Title',
    int status = 0,
    IconData icon = Icons.person_rounded,
    bool hasIconStatus = true,
    Function? click}) {
  return SizedBox(
    width: 82.0,
    height: 62.0,
    child: GestureDetector(
      child: Stack(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: circleIcon(status: status, icon: icon)),
              Align(
                alignment: const Alignment(0.4, 0.2),
                child: SizedBox(
                  width: 16.0,
                  height: 16.0,
                  child: hasIconStatus ? statusIcon(status: status) : null,
                ),
              )
            ],
          ),
          Transform.translate(
            offset: Offset(0.0, 50.0),
            child: Container(
              width: 82.0,
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 8,
                  color: ResiklosColors.muted,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        if (click != null) {
          click();
        }
      },
      behavior: HitTestBehavior.opaque,
    ),
  );
}

Widget circleIcon({int status = 0, IconData icon = Icons.person_rounded}) {
  Color border = ResiklosColors.light;
  Color bg = ResiklosColors.muted;
  Color textColor = Colors.white;

  if (status == 1) {
    // pending
    border = ResiklosColors.light;
    bg = ResiklosColors.muted;
    textColor = Colors.white;
  } else if (status == 2) {
    // completed
    border = const Color(0xff00a6be);
    bg = Colors.white;
    textColor = const Color(0xff00a6be);
  } else if (status == 3) {
    // rejected
    border = ResiklosColors.light;
    bg = ResiklosColors.muted;
    textColor = Colors.white;
  }

  return Stack(
    children: <Widget>[
      AnimatedContainer(
        alignment: Alignment.center,
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          border: Border.all(width: 5.0, color: border),
        ),
        child: SizedBox.expand(
          child: Icon(icon, color: textColor, size: 18),
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    ],
  );
}

Widget statusIcon({int status = 0}) {
  // initial -- incomplete
  IconData icon = CupertinoIcons.exclamationmark;
  Color bg = ResiklosColors.warningDark;

  if (status == 1) {
    // pending
    icon = CupertinoIcons.minus;
    bg = ResiklosColors.primary;
  } else if (status == 2) {
    // completed
    icon = CupertinoIcons.check_mark;
    bg = ResiklosColors.success;
  } else if (status == 3) {
    // rejected
    icon = CupertinoIcons.xmark;
    bg = const Color(0xFFF1222B);
  }

  return Stack(
    children: <Widget>[
      AnimatedContainer(
        decoration: BoxDecoration(
          color: bg,
          borderRadius:
              const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          border: Border.all(width: 2.0, color: const Color(0xffffffff)),
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
      AnimatedPadding(
        padding: const EdgeInsets.all(3.0),
        child:
            SizedBox.expand(child: Icon(icon, color: Colors.white, size: 10)),
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    ],
  );
}
