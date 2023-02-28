import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/navigator_util.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? bgColor;
  final Widget? rightTitle;

  const CustomAppBar(
      {Key? key, required this.title, this.bgColor, this.rightTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          child: Container(
            color: bgColor ?? Colors.white,
            alignment: Alignment.center,
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    NavigatorUtil.pop(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.center,
                    width: 40,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff00A6BE),
                      size: 20,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xff00A6BE),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                )),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    child: rightTitle,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
