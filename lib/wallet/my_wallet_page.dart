import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/transactions/transaction_segment_view.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/wallet/my_wallet_activity_page.dart';
import 'package:resiklos/wallet/my_wallet_assets_page.dart';
import 'package:resiklos/wallet/my_wallet_button_widget.dart';
import 'package:resiklos/wallet/wallet_card.dart';
import 'package:resiklos/wallet/wallet_request.dart';

class MyWalletPage extends BaseStatefulWidget {
  const MyWalletPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _MyWalletPageState();
}

class _MyWalletPageState extends BaseStatefulState<MyWalletPage> {
  final PageController _pageController = PageController();
  final List<String> list = [
    'ASSETS',
    'ACTIVITY',
  ];
  List pages = const [MyWalletAssetsPage(), MyWalletActivityPage()];
  int _index = 0;
  num rsg = 0;

  @override
  void initState() {
    super.initState();
  }

  void fetchData() async {
    var res = await fetchWallet();
    if (res != null && res is Map) {
      setState(() {
        rsg = res["rsgBalance"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 30,
                      top: MediaQuery.of(context).padding.top,
                      right: 30),
                  height: MediaQuery.of(context).padding.top + kToolbarHeight,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.5),
                            color: const Color(0xff75BE00)),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "1234556jjj8888",
                            style:
                                TextStyle(fontSize: 12, color: color_707070()),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(
                        child: Icon(
                          Icons.home,
                          size: 20,
                          color: mainColor(),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: WalletCard(
                    rsg: rsg,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20, right: 40),
                  child: MyWalletButtonWidget(
                    clickItem: (index) {},
                  ),
                ),
                DepositTransactionSegmentView(
                  index: _index,
                  isShop: true,
                  titles: list,
                  click: (index) {
                    log("$index");
                    setState(() {
                      _index = index;
                    });
                    _pageController.jumpToPage(index);
                  },
                ),
                Container(
                  color: color_FAFAFA(),
                  height: 200,
                  child: PageView(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _index = value;
                        });
                        log("on page changed $value");
                      },
                      children: list.map((e) {
                        return Container(child: pages[list.indexOf(e)]);
                      }).toList()),
                )
              ],
            ),
          )),
    );
  }
}
