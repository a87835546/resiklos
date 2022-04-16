import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:resiklos/home/home_verify_emal_page.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/constants.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/wallet/status_icon_widget.dart';

Widget VerificationCardWidget(BuildContext context, UserInfoModel? user) {
  double progress = 0.20;

  return Container(
    margin: const EdgeInsets.only(top: 20),
    // padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Container(
      height: 156.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 100.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.987, 1.0),
                end: Alignment(1.0, 1.0),
                colors: [
                  Color(0xff00a6be),
                  Color(0xff00a6be),
                  Color(0xff0cc9be)
                ],
                stops: [0.0, 0.276, 1.0],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100.0,
            padding: const EdgeInsets.only(left: 30.0, top: 5.0),
            child: Stack(
              children: [
                BlendMask(
                  blendMode: BlendMode.colorDodge,
                  child: Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            const AssetImage('imgs/verification_bg_image.png'),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.25), BlendMode.dstIn),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 91.0, top: 10.0, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 219.0,
                        height: 21.0,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffffcc5a),
                            ),
                            children: [
                              TextSpan(
                                text: 'ACCOUNT',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: ' VERIFICATION',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          softWrap: false,
                        ),
                      ),
                      SizedBox(
                        width: 219.0,
                        height: 37.0,
                        child: Text(
                          'Complete account verification to unlock all app features. Link or create your wallet to enable transfers.',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xcdffffff),
                            fontWeight: FontWeight.w500,
                            height: 1.3333333333333333,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0.0, 100.0),
            child: SizedBox(
              width: double.infinity,
              height: 8.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 360.0,
                    height: 8.0,
                    color: ResiklosColors.light,
                  ),
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      progress = 0;
                      if (user == null) {
                        return Container();
                      }
                      if (user.verificationStatus >= 1) {
                        progress = 0.5;
                      }

                      if (user.verificationStatus >= 2 &&
                          user.kycVerificationStatus > 0) {
                        progress = 0.8;
                      }

                      if (user.verificationStatus == 3 &&
                          user.kycVerificationStatus != 3) {
                        progress = 1;
                      }

                      return AnimatedContainer(
                        width: constraints.maxWidth * progress,
                        height: 8.0,
                        color: const Color(0xff0d90a3),
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 84.0),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatusIconWidget(
                    title: 'Verify Email',
                    status: user!.verificationStatus >= 1 ? 2 : 0,
                    icon: CupertinoIcons.mail_solid,
                    click: () {
                      if (AppSingleton.userInfoModel?.emailVerificationStatus ==
                          0) {
                        NavigatorUtil.push(context, const HomeVerifyEmail());
                      }
                    }),
                StatusIconWidget(
                    title: 'Confirm Identity',
                    status: user.verificationStatus == 2 &&
                            user.kycVerificationStatus > 0
                        ? 2
                        : user.kycVerificationStatus,
                    icon: CupertinoIcons.person_fill),
                StatusIconWidget(
                    title: 'Fully Verified',
                    status: user.verificationStatus == 3
                        ? 2
                        : (user.kycVerificationStatus == 1 ? 1 : 0),
                    icon: CupertinoIcons.checkmark_seal_fill)
              ],
            ),
          )
        ],
      ),
    ),
  );
}
