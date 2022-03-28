import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:resiklos/mine/mine_list_item.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';

class MineList extends StatefulWidget {
  const MineList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MineListState();
}

class _MineListState extends State<MineList> {
  bool isShow = false;
  String? _version;

  @override
  void initState() {
    super.initState();
    loadVersion();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            "PERSONAL INFORMATION",
            style: TextStyle(color: color_d4d4d4()),
          ),
        ),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            MineListItem(
                title: "Email",
                subTitle: AppSingleton?.userInfoModel?.email ?? ""),
            MineListItem(
              title: 'Full Name',
              subTitle: AppSingleton.userInfoModel?.nickName ?? "",
            ),
            MineListItem(
              subTitle: AppSingleton.userInfoModel?.inviteCode ?? "",
              title: 'Referral Code',
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            "SETTINGS",
            style: TextStyle(color: color_d4d4d4()),
          ),
        ),
        MineListItem(
          title: "Change Password",
          right: GestureDetector(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color_d4d4d4(),
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          ),
        ),
        MineListItem(
          title: "Face ID",
          right: Container(
            alignment: Alignment.centerRight,
            width: double.maxFinite,
            child: Switch(
              value: isShow,
              onChanged: (v) {
                setState(() {
                  isShow = !isShow;
                });
              },
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            "",
            style: TextStyle(color: color_d4d4d4()),
          ),
        ),
        MineListItem(
          title: "About",
          right: GestureDetector(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color_d4d4d4(),
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          ),
        ),
        MineListItem(
          title: "Terms & Conditions",
          right: GestureDetector(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color_d4d4d4(),
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          ),
        ),
        MineListItem(
          title: "Privacy Policy",
          right: GestureDetector(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color_d4d4d4(),
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          ),
        ),
        MineListItem(
          title: "Disable Account",
          right: GestureDetector(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: color_d4d4d4(),
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          ),
        ),
        MineListItem(
          title: "App Version",
          subTitle: _version,
        ),
      ],
    );
  }

  void loadVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version; //版本号
    String buildNumber = packageInfo.buildNumber; //版本构建号
    setState(() {
      _version = version;
    });
  }
}
