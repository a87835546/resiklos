import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignButton extends StatelessWidget {
  final Function? click;
  final String title;
  final bool disable;
  final double? width;
  final Color? bgColor;
  const SignButton(
      {Key? key, this.click, required this.title, required this.disable,this.width,this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = width ?? 200;
    return Padding(
      padding: EdgeInsets.only(
          left: (MediaQuery.of(context).size.width - w) / 2,
          right: (MediaQuery.of(context).size.width - w) / 2),
      child: GestureDetector(
        onTap: () async {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          FocusManager.instance.primaryFocus?.unfocus();
          FocusScope.of(context).requestFocus(FocusScopeNode());
          if (click != null) {
            click!();
          }
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: disable == true
                  ? bgColor??Color(0xff00A6BE)
                  : Color(0xff00A6BE).withAlpha(10)),
          height: 50,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                color: disable == true ? Colors.white : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
