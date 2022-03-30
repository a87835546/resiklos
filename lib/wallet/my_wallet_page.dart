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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 30, top: MediaQuery.of(context).padding.top, right: 30),
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
                        style: TextStyle(fontSize: 12, color: color_707070()),
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
            Center(child:WalletCard() ,),
            // Padding(padding: EdgeInsets.only(left: 15,right: 15),child: WalletCard(),),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15, right: 15),
            //   child: Container(
            //       height: 180,
            //       clipBehavior: Clip.antiAlias,
            //       decoration: BoxDecoration(
            //         color: mainColor(),
            //         image: DecorationImage(image: Image.asset("imgs/wallet/tether_usdt_logo.svg").image,),
            //         borderRadius: BorderRadius.circular(10),
            //         boxShadow: const [
            //           BoxShadow(
            //               color: Color(0x29000000),
            //               blurRadius: 6.0,
            //               offset: Offset(0, 2),
            //               spreadRadius: 0)
            //         ],
            //       ),
            //       child: Stack(
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.only(left: 12, right: 12),
            //             color: Colors.redAccent,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Container(
            //                   height: 40,
            //                   child: Column(
            //                     children: [
            //                       Container(
            //                         height: 20,
            //                         alignment: Alignment.center,
            //                         child: const Text(
            //                           "RSG Wallet",
            //                           style: TextStyle(
            //                               color: Colors.white,
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 12),
            //                         ),
            //                       ),
            //                       Container(
            //                         height: 20,
            //                         alignment: Alignment.center,
            //                         child: Text(
            //                           "Resiklos Gems",
            //                           style: TextStyle(
            //                               color: Colors.white.withOpacity(0.6),
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 10),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Expanded(
            //                     child: Container(
            //                   height: 40,
            //                   child: Row(
            //                     mainAxisAlignment: MainAxisAlignment.end,
            //                     children: [
            //                       Container(
            //                         child: Text(
            //                           "RP:${AppSingleton.userInfoModel?.rpWalletAddress}",
            //                           style:const TextStyle(
            //                               color: Colors.white,
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 12),
            //                         ),
            //                       ),
            //                       Container(
            //                         padding: EdgeInsets.only(left: 5, right: 5),
            //                         child: Icon(
            //                           Icons.copy,
            //                           color: mainColor(),
            //                           size: 12,
            //                         ),
            //                       ),
            //                       Container(
            //                         padding: EdgeInsets.only(left: 0, right: 5),
            //                         child: Icon(
            //                           Icons.share,
            //                           color: mainColor(),
            //                           size: 12,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ))
            //               ],
            //             ),
            //           ),
            //           Positioned(
            //             child: Container(
            //               height: 40,
            //               alignment: Alignment.center,
            //               width: MediaQuery.of(context).size.width - 30,
            //               child: const Text(
            //                 "500 RSG",
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 34,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //             left: 0,
            //             top: 70,
            //           ),
            //           Positioned(
            //             child: Container(
            //               alignment: Alignment.center,
            //               clipBehavior: Clip.antiAlias,
            //               width: 80,
            //               height: 80,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(40),
            //                   color: Colors.white),
            //               child: Container(
            //                 width: 60,
            //                 height: 60,
            //                 alignment: Alignment.center,
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(30),
            //                     color: Colors.transparent),
            //                 child: Image.asset(
            //                   "imgs/logo@2x.png",
            //                   width: 60,
            //                   height: 60,
            //                 ),
            //               ),
            //             ),
            //             left: (MediaQuery.of(context).size.width - 110) / 2,
            //             top: 0,
            //           )
            //         ],
            //       )),
            // ),
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
      ),
    );
  }
}
