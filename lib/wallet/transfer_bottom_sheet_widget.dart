import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resiklos/utils/constants.dart';
import 'package:resiklos/wallet/badge_widget.dart';


void showTransferBottomSheetWidget(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return SafeArea(
            minimum: EdgeInsets.only(bottom: 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'Transfer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Ink(
                          width: 30,
                          height: 30,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                            color: Color(0xFFEEEEF0),
                          ),
                          child: IconButton(
                            splashRadius: 20,
                            padding: const EdgeInsets.all(0),
                            icon: const Icon(Icons.clear_rounded),
                            iconSize: 20,
                            color: Colors.grey,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  horizontalTitleGap: 5,
                  leading: SvgPicture.asset('imgs/svg/gem.svg',
                      width: 30, height: 26, color: ResiklosColors.primary),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Send via Resiklos Email or ID',
                        style: TextStyle(
                          fontSize: 14,
                          color: ResiklosColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Send to Resiklos user. Instant transfer. No fees.',
                        style: TextStyle(
                          fontSize: 10,
                          color: ResiklosColors.muted,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
                  style: ListTileStyle.drawer,
                ),
                const Divider(height: 1),
                Opacity(
                  opacity: 0.7,
                  child: ListTile(
                    enabled: false,
                    horizontalTitleGap: 5,
                    leading: const Icon(Icons.logout,
                        size: 30, color: ResiklosColors.primary),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Send via Crypto Network',
                            style: TextStyle(
                              fontSize: 14,
                              color: ResiklosColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(
                              alignment: PlaceholderAlignment.top,
                              child: BadgeWidget(text: 'Maintenance')),
                        ])),
                        SizedBox(height: 2),
                        Text(
                          'Send to a known crypto address via crypto network',
                          style: TextStyle(
                            fontSize: 10,
                            color: ResiklosColors.muted,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 35),
                    style: ListTileStyle.drawer,
                  ),
                ),
                const Divider(height: 1),
              ],
            ));
      });
}
