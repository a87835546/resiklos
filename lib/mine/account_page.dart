import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/constants.dart';
import 'package:resiklos/wallet/show_toast.dart';
import 'package:resiklos/wallet/status_icon_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: kToolbarHeight + 20),
          width: double.infinity,
          height: kToolbarHeight + 270,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                offset: Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 62.5,
                      child: AppSingleton.userInfoModel?.avatar == null
                          ? Text(
                              AppSingleton.userInfoModel?.nickName ??
                                  "full name",
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold))
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AppSingleton
                                          .userInfoModel?.avatar ==
                                      null
                                  ? Image.asset("imgs/default_avatar.png").image
                                  : NetworkImage(
                                      AppSingleton.userInfoModel?.avatar ?? ""),
                              radius: 62.5,
                            ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(68.0, 78.0),
                    child: SizedBox(
                      width: 26.0,
                      height: 26.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 26.0,
                            height: 26.0,
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(3.0, 3.0),
                            child: SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: SvgPicture.asset(
                                      'assets/svg/facebook_icon.svg',
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                AppSingleton.userInfoModel?.fullName ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                          text: '${AppSingleton.userInfoModel?.userId}'))
                      .then((_) {
                    showToast(context, 'ID copied');
                  });
                },
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: ResiklosColors.muted,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: 'ID: '),
                      TextSpan(
                        text: '${AppSingleton.userInfoModel?.userId ?? ""}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 3),
                      ),
                      const WidgetSpan(
                        alignment: PlaceholderAlignment.top,
                        child: Icon(CupertinoIcons.doc_on_clipboard,
                            size: 14, color: ResiklosColors.muted),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: 250.0,
                          height: 2.0,
                          color: const Color(0xffd4d4d4),
                        ),
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            if (AppSingleton.userInfoModel == null) {
                              return Container();
                            }
                            UserInfoModel user = AppSingleton.userInfoModel!;
                            var status = user.verificationStatus;

                            if (status > 1 &&
                                AppSingleton
                                        .userInfoModel?.kycVerificationStatus !=
                                    3) {
                              progress = 1;
                            } else if (status == 1) {
                              progress = 0.5;
                            } else if (status == 0) {
                              progress = 0;
                            }

                            return AnimatedContainer(
                              constraints: const BoxConstraints(maxWidth: 250),
                              width: 250.0 * progress,
                              height: 2.0,
                              color: const Color(0xff0d90a3),
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 335),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatusIconWidget(
                              title: 'Verify Email',
                              status: AppSingleton
                                          .userInfoModel!.verificationStatus >=
                                      1
                                  ? 2
                                  : 0,
                              icon: CupertinoIcons.mail_solid),
                          StatusIconWidget(
                              title: 'Confirm Identity',
                              status: AppSingleton.userInfoModel!
                                              .verificationStatus ==
                                          2 &&
                                      AppSingleton.userInfoModel!
                                              .kycVerificationStatus >
                                          0
                                  ? 2
                                  : AppSingleton
                                      .userInfoModel!.kycVerificationStatus,
                              icon: CupertinoIcons.person_fill),
                          StatusIconWidget(
                            title: 'Fully Verified',
                            status: AppSingleton
                                        .userInfoModel?.verificationStatus ==
                                    3
                                ? 2
                                : (AppSingleton.userInfoModel
                                            ?.kycVerificationStatus ==
                                        1
                                    ? 1
                                    : 0),
                            icon: CupertinoIcons.checkmark_seal_fill,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                      title: const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        AppSingleton.userInfoModel?.email ?? "",
                        style: const TextStyle(
                          color: ResiklosColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        AppSingleton.userInfoModel?.fullName ?? "",
                        style: const TextStyle(
                          color: ResiklosColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Nickname',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        AppSingleton.userInfoModel?.nickName ?? "",
                        style: const TextStyle(
                          color: ResiklosColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Referral Code',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        AppSingleton.userInfoModel?.inviteCode ?? "",
                        style: const TextStyle(
                          color: ResiklosColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ]).toList(),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 45),
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: FlatButton(
                    onPressed: () {},
                    child: const Text(
                      'Logout',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    color: ResiklosColors.dark,
                    textColor: Colors.white,
                    disabledColor: Colors.grey.shade300,
                    disabledTextColor: Colors.white60,
                    minWidth: double.infinity,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
