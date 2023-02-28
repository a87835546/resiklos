import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/notification/notification_model.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
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
            int index = _list.indexOf(e);
            return Container(
              padding: EdgeInsets.only(left: 18, right: 18, bottom: 10),
              height: 60,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Text(
                                  e.content ?? "",
                                  style: TextStyle(
                                      color: color_707070(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  e.description ?? "",
                                  style: TextStyle(
                                      color: color_707070(), fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(""),
                              ),
                              Container(
                                child: Text(
                                  e.time ?? "",
                                  style: TextStyle(
                                      color: color_d4d4d4(), fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    child: Divider(
                      color: color_d4d4d4(),
                      height: 1,
                    ),
                    visible: index < (_list.length - 1),
                  )
                ],
              ),
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
      for (var e in temp) {
        _noti.add(NotificationModel.fromJson(e));
      }
      setState(() {
        _list = _noti;
        log("message ---->>>>$_list");
      });
    } catch (e) {
      log("解析出错--->>>$e");
    }
  }
}
