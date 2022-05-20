import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/home_articles_widget.dart';
import 'package:resiklos/home/home_top_container_widget.dart';
import 'package:resiklos/home/summary_card_widget.dart';
import 'package:resiklos/home/verification_card_widget.dart';
import 'package:resiklos/model/user_info_model.dart';
import 'package:resiklos/utils/TokenTx.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/event_bus_util.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/toast.dart';
import 'package:resiklos/wallet/my_wallet_page.dart';

import 'home_invite_widget.dart';
import 'home_navi_widget.dart';

class HomePage extends BaseStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _HomePageState();
}

class _HomePageState extends BaseStatefulState<HomePage>
    with AutomaticKeepAliveClientMixin {
  final _controller = ScrollController();
  final RefreshController _refreshController = RefreshController();
  String _rsgBalance = "0";
  num? _points = AppSingleton.userInfoModel?.gems;
  num? _rate = 0;
  UserInfoModel? _model;
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    getData();
    loadBalance();
    _streamSubscription = EventBusUtil.listen((event) {
      log("home page event listen -----------?>>>>>>>>>>> $event");
      if (event is RefreshRpEvent) {
        getAmount();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }

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
                        // padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ListView(
                          controller: _controller,
                          shrinkWrap: true,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            HomeTopContainerView(
                              points: _points ?? 0,
                              count: _rsgBalance,
                              exchangeRate: _rate ?? 1,
                            ),
                            // SummaryCardWidget(context,
                            //     affiliatesCount: _referralCount,
                            //     amount: _points ?? 0),

                            // Padding(
                            //   padding: EdgeInsets.only(top: 30),
                            //   child: Container(
                            //     height: 156,
                            //     child: HomeVerifyView(
                            //       model: _model,
                            //     ),
                            //   ),
                            // ),

                            FutureBuilder(builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              bool status = _model != null &&
                                  (_model?.emailVerificationStatus != null ||
                                      _model?.kycVerificationStatus != null);
                              log("has data --->>>$status");
                              if (!status) {
                                return Container();
                              } else {
                                return Visibility(
                                  child: Padding(
                                    child:
                                        VerificationCardWidget(context, _model),
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                  ),
                                  visible: status,
                                );
                              }
                            }),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 30, left: 15, right: 15),
                              child: HomeInviteView(),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 6 + 15, top: 30),
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
                              padding:
                                  EdgeInsets.only(top: 5, left: 15, right: 15),
                              child: HomeArticlesView(
                                isResiklos: true,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15, right: 15),
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
    Future.wait([loadBalance(), getPoints(), getUser(), getAmount()])
        .whenComplete(() {
      _refreshController.refreshCompleted();
      EasyLoading.dismiss();
    });
  }

  Future getReferralsCount() async {
    var r = await HttpManager.get(
        url: "user/referralsCount",
        params: {"referralCode": AppSingleton.userInfoModel?.inviteCode ?? ""});
    log("referral count --->>>$r");
    if (mounted && r["data"] != null) {
      setState(() {});
    }
  }

  Future<void> loadBalance() async {
    if (AppSingleton.userInfoModel?.walletAddress != null ||
        AppSingleton.userInfoModel?.walletAddress != "") {
      TokenTx.getBalances(AppSingleton.userInfoModel?.walletAddress ?? "")
          .then((value) {
        log("balance 0--->>>$value");

        for (var element in value) {
          if (element.symbol == WalletType.RSGT.name) {
            log("rsgt ---->>>${element.balance}");
            if (mounted) {
              setState(() {
                try {
                  _rsgBalance = element.balance.toString();
                } catch (e) {
                  log("err--->>>$e");
                }
              });
            }
          }
        }
      });
    }
  }

  Future getPoints() async {
    var r = await HttpManager.get(
        url: "user/points",
        params: {"userEmail": "${AppSingleton.userInfoModel?.email}"});
    log("points --->>>$r");
    if (mounted &&
        r["data"] != null &&
        mounted &&
        (AppSingleton.userInfoModel?.emailVerificationStatus != 1 ||
            AppSingleton.userInfoModel?.kycVerificationStatus != 2)) {
      setState(() {
        _points = r["data"]["point"] ?? 0;
      });
    }
  }

  Future getUser() async {
    var r = await HttpManager.get(
        url: "user/getInfo",
        params: {"userId": "${AppSingleton.userInfoModel?.email}"});
    log("user info res ------>>>>$r");
    if (mounted && r["data"] != null) {
      var temp = r["data"];
      UserInfoModel object = UserInfoModel.fromJson(temp);
      setState(() {
        _model = object;
      });
      AppSingleton.setUserInfoModel(object);
    }
  }

  Future getAmount() async {
    var res = await HttpManager.get(
        url: "wallet/balance?email=${AppSingleton.userInfoModel?.email}");
    log("balance --->>>$res");
    try {
      setState(() {
        _rate = num.parse(res["data"]["exchangeRate"] ?? "1");
      });
      if (mounted && AppSingleton.userInfoModel?.emailVerificationStatus == 1 && AppSingleton.userInfoModel?.kycVerificationStatus == 2) {
        setState(() {
          _points = num.parse(res["data"]["rpBalance"] ?? "0");
        });
      } else {
        setState(() {
          _points = AppSingleton.userInfoModel?.gems ?? 0;
        });
      }
    } catch (e) {
      log("获取余额错误 ${e.toString()}");
    }
  }

  @override
  bool get wantKeepAlive => true;
}
