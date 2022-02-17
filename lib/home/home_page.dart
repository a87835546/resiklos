import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/home_articles_widget.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/toast.dart';

import 'home_invite_widget.dart';
import 'home_navi_widget.dart';
import 'home_top_container_widget.dart';

class HomePage extends BaseStatefulWidget {
  final UserInfoModel? model;

  const HomePage({Key? key, required this.model}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _HomePageState();
}

class _HomePageState extends BaseStatefulState<HomePage> {
  var _controller = ScrollController();
  final RefreshController _refreshController = RefreshController();
  int _referralCount = 0;
  num? _points =  AppSingleton.userInfoModel?.gems;

  @override
  Widget build(BuildContext context) {
    return _widget();
  }

  Widget _widget() {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Container(
              height: MediaQuery.of(context).size.height +
                  MediaQuery.of(context).padding.bottom,
              child: Column(
                children: [
                  HomeNaviView(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  Container(
                    height: 15,
                    color: Colors.transparent,
                  ),
                  Expanded(
                    child: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: () async {
                        getData();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ListView(
                          controller: _controller,
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            HomeTopContainerView(
                              points: _points??50,
                              count: _referralCount,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: HomeInviteView(),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 6, top: 30),
                              alignment: Alignment.topLeft,
                              child: const Text(
                                "ARTICLES",
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color(0xffD4D4D4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              child: HomeArticlesView(
                                isResiklos: true,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: HomeArticlesView(
                                isResiklos: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void getData() async {
    showLoading();
    Future.wait([getReferralsCount(), getPoints()]).whenComplete(() {
      _refreshController.refreshCompleted();
      EasyLoading.dismiss();
    });
  }

  Future getReferralsCount() async {
    var r = await HttpManager.get(
        url: "user/referralsCount",
        params: {"referralCode": AppSingleton.userInfoModel?.inviteCode ?? ""});
    if(mounted && r["data"] != null){
      setState(() {
        _points = r["data"]["point"]??50;
      });
    }
  }

  Future getPoints() async {
    var r = await HttpManager.get(
        url: "user/points",
        params: {"id": "${AppSingleton.userInfoModel?.id}"});
    if(mounted && r["data"] != null){
      setState(() {
        _referralCount  = r["data"]["count"]??0;
      });
    }
  }
}
