import 'package:flutter/material.dart';
import 'package:resiklos/utils/constants.dart';

Widget WalletButtonWidget(BuildContext context,
        {required IconData icon,
        required String text,
        dynamic onPressed = defaultEvent,
        bool isEnabled = true}) =>
    Opacity(
      opacity: !isEnabled ? 0.3 : 1,
      child: Column(
        children: <Widget>[
          Container(
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
              color: const Color(0xfff7fafc),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: FlatButton(
              highlightColor: Colors.blueGrey.shade50,
              splashColor: Colors.blueGrey.shade200,
              color: const Color(0xfff7fafc),
              padding: const EdgeInsets.all(12.5),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              onPressed: onPressed,
              child: Icon(icon, size: 30, color: ResiklosColors.primary),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 55.0,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                color: ResiklosColors.primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

void defaultEvent() {}
