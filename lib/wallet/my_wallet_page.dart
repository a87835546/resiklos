// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:resiklos/base_class/base_page.dart';
// import 'package:resiklos/home/transactions/transaction_segment_view.dart';
// import 'package:resiklos/utils/app_singleton.dart';
// import 'package:resiklos/utils/color.dart';
// import 'package:resiklos/wallet/my_wallet_activity_page.dart';
// import 'package:resiklos/wallet/my_wallet_assets_page.dart';
// import 'package:resiklos/wallet/my_wallet_button_widget.dart';
// import 'package:resiklos/wallet/wallet_card.dart';
// import 'package:resiklos/wallet/wallet_request.dart';
//
// class MyWalletPage extends BaseStatefulWidget {
//   const MyWalletPage({Key? key}) : super(key: key);
//
//   @override
//   BaseStatefulState<BaseStatefulWidget> getState() => _MyWalletPageState();
// }
//
// class _MyWalletPageState extends BaseStatefulState<MyWalletPage> {
//   final PageController _pageController = PageController();
//   final List<String> list = [
//     'ASSETS',
//     'ACTIVITY',
//   ];
//   List pages = const [MyWalletAssetsPage(), MyWalletActivityPage()];
//   int _index = 0;
//   num rsg = 0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void fetchData() async {
//     var res = await fetchWallet();
//     if (res != null && res is Map) {
//       setState(() {
//         rsg = res["rsgBalance"];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: MediaQuery.removePadding(
//           context: context,
//           removeTop: true,
//           child: Container(
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: 30,
//                       top: MediaQuery.of(context).padding.top,
//                       right: 30),
//                   height: MediaQuery.of(context).padding.top + kToolbarHeight,
//                   color: Colors.white,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: 5,
//                         height: 5,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(2.5),
//                             color: const Color(0xff75BE00)),
//                       ),
//                       Expanded(
//                         child: Container(
//                           padding: const EdgeInsets.only(left: 5),
//                           child: Text(
//                             "1234556jjj8888",
//                             style:
//                                 TextStyle(fontSize: 12, color: color_707070()),
//                           ),
//                         ),
//                         flex: 1,
//                       ),
//                       Container(
//                         child: Icon(
//                           Icons.home,
//                           size: 20,
//                           color: mainColor(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Center(
//                   child: WalletCard(
//                     rsg: rsg,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 40, top: 20, right: 40),
//                   child: MyWalletButtonWidget(
//                     clickItem: (index) {},
//                   ),
//                 ),
//                 DepositTransactionSegmentView(
//                   index: _index,
//                   isShop: true,
//                   titles: list,
//                   click: (index) {
//                     log("$index");
//                     setState(() {
//                       _index = index;
//                     });
//                     _pageController.jumpToPage(index);
//                   },
//                 ),
//                 Container(
//                   color: color_FAFAFA(),
//                   height: 200,
//                   child: PageView(
//                       controller: _pageController,
//                       onPageChanged: (value) {
//                         setState(() {
//                           _index = value;
//                         });
//                         log("on page changed $value");
//                       },
//                       children: list.map((e) {
//                         return Container(child: pages[list.indexOf(e)]);
//                       }).toList()),
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/constants.dart';
import 'package:resiklos/wallet/setup_wallet_step1_page.dart';
import 'package:resiklos/wallet/transfer_bottom_sheet_widget.dart';
import 'package:resiklos/wallet/wallet_button_widget.dart';
import 'package:resiklos/wallet/wallet_card_widget.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({Key? key}) : super(key: key);

  @override
  State<MyWalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<MyWalletPage> {
  double progress = 0;
  int selectedIndex = 0;

  final List assets = [
    ListItem("RSG", 'Resiklos Gems', AppSingleton.userInfoModel?.gems,
        'imgs/logo@2x.png'),
    ListItem("BNB", 'Binance Coin', 2.5943, 'imgs/svg/bnb.svg', type: 'svg'),
    ListItem("USDT", 'Tether', 0, 'imgs/svg/usdt.svg', type: 'svg')
  ];

  @override
  Widget build(BuildContext context) {
    log("adddress --- >>>${AppSingleton.userInfoModel?.walletAddress}");
    return Scaffold(
      body: AppSingleton.userInfoModel?.walletAddress == null
          ? SetupWalletStep1Page()
          : Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 390, left: 15, right: 15),
                  child: ListView.builder(
                    itemCount: assets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimatedContainer(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              width: 1.0,
                              color: selectedIndex == index
                                  ? const Color(0xff00a6be)
                                  : Colors.white),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0d000000),
                              offset: Offset(0, 3),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 20),
                          style: ListTileStyle.drawer,
                          tileColor: Colors.white,
                          leading: assets[index].type == 'svg'
                              ? SvgPicture.asset(assets[index].icon,
                                  width: 45, height: 45)
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 22.5,
                                  child: Image.asset(
                                    assets[index].icon,
                                  ),
                                ),
                          title: Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(text: assets[index].amount.toString()),
                                const TextSpan(text: " "),
                                TextSpan(
                                  text: assets[index].coin,
                                ),
                              ],
                            ),
                          ),
                          trailing: const Icon(CupertinoIcons.right_chevron),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 410,
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
                  child: SafeArea(
                    top: true,
                    bottom: false,
                    left: false,
                    right: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              margin: const EdgeInsets.only(
                                  left: 25, bottom: 15, top: 22),
                              width: 194.0,
                              height: 25.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.bottom,
                                      child: Icon(
                                          CupertinoIcons
                                              .smallcircle_fill_circle_fill,
                                          size: 12,
                                          color: Colors.green),
                                    ),
                                    WidgetSpan(
                                      child: SizedBox(width: 5),
                                    ),
                                    TextSpan(
                                      text: 'Binance Smart Chain Network',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 20),
                                child: FlatButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.zero,
                                  minWidth: 40,
                                  height: 35,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  onPressed: () {
                                    log('Show QR', name: 'screens/wallet_page');
                                  },
                                  child: const Icon(Icons.qr_code_rounded,
                                      size: 24, color: ResiklosColors.primary),
                                ),
                              ),
                            )
                          ],
                        ),
                        WalletCardWidget(context,
                            asset: assets[selectedIndex],
                            address:
                                (AppSingleton.userInfoModel?.walletAddress ??
                                        "")
                                    .toLowerCase()),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WalletButtonWidget(context,
                                icon: CupertinoIcons.creditcard_fill,
                                text: 'Deposit',
                                isEnabled: false),
                            const SizedBox(width: 32),
                            WalletButtonWidget(context,
                                icon: CupertinoIcons.paperplane_fill,
                                text: 'Transfer', onPressed: () {
                              showTransferBottomSheetWidget(context);
                            }),
                            const SizedBox(width: 32),
                            WalletButtonWidget(context,
                                icon: CupertinoIcons.arrow_swap,
                                text: 'Swap',
                                isEnabled: false)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class ListItem {
  String coin;
  String name;
  dynamic amount;
  String icon;
  String? type = 'image';

  ListItem(this.coin, this.name, this.amount, this.icon,
      {this.type}); //Constructor to assign the data
}
