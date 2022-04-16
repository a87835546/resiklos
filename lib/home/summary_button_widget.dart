import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget SummaryButtonWidget(String text,
        {String icon = '',required Function onPressed}) =>
    Expanded(
      child: FlatButton(
        onPressed: onPressed(),
        // splashColor: Colors.blueGrey.shade50,
        highlightColor: Colors.blueGrey.shade50,
        textColor: Colors.black,
        padding: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
              child: SvgPicture.asset(icon,
                  allowDrawingOutsideViewBox: false, height: 30.0),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xff00a8bf),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
