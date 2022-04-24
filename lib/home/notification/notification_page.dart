import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/notification/notification_model.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';

class NotificationPage extends BaseStatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _NotificationPageState();
}

class _NotificationPageState extends BaseStatefulState<NotificationPage> {
  int _page = 1;
  final RefreshController _refreshController = RefreshController();
  List<NotificationModel> _list = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notifications",
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () => fetch(),
        child: ListView(
          children: _list.map((e) {
            return Container(
              height: 60,
              color: Colors.red,
              child: Text(e.content ?? ""),
            );
          }).toList(),
        ),
      ),
    );
  }

  void fetch() async {
    _refreshController.refreshCompleted();
    var res = await HttpManager.get(
        url:
            "notification/queryNotificationsByUserId?userId=${AppSingleton.userInfoModel?.id}&current=$_page&size=10");
    log("noti --->>>$res");
    try {
      List temp = res["data"];
      List<NotificationModel> _noti = [];
      temp.forEach((e) {
        _noti.add(NotificationModel.fromJson(e));
      });
      setState(() {
        _list = _noti;
        log("message ---->>>>$_list");
      });
    } catch (e) {
      log("解析出错--->>>$e");
    }
  }
}
