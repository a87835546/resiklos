import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resiklos/shop/marketplace_request.dart';
import 'package:resiklos/shop/merchant_model.dart';
import 'package:resiklos/shop/shop_vouchers_page.dart';
import 'package:resiklos/shop/voucher_model.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/constants.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

const double kItemSize = 120;

class _MarketplacePageState extends State<MarketplacePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<MerchantModel> _list1 = [];
  MerchantModel? _select;
  final TextEditingController _textEditingController = TextEditingController();
  String? _keyword;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    getData();
  }

  void getData() async {
    var list = await MarketPlaceRequest.getList(keyword: _keyword);
    log("merchant list --->>$list");
    setState(() {
      _list1 = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              toolbarHeight: 5,
              collapsedHeight: 5,
              foregroundColor: Colors.blueGrey,
              pinned: true,
              floating: false,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: Container(
                height: 1000,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("imgs/merchant_top_cover.png"),
                      // NetworkImage('https://picsum.photos/400/400'),
                      fit: BoxFit.cover),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: Material(
                  color: ResiklosColors.dark.withOpacity(0.7),
                  child: TabBar(
                    indicatorWeight: 5,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.white,
                    indicatorPadding:
                        EdgeInsets.only(bottom: 5.0, left: 20, right: 20),
                    tabs: const <Tab>[
                      Tab(text: 'Merchants'),
                      Tab(text: 'Vouchers'),
                    ],
                    controller: _tabController,
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: RefreshIndicator(
                strokeWidth: 1,
                onRefresh: () async {
                  getData();
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        children: [
                          const Text(
                            'PARTNER MERCHANTS',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          const SizedBox(
                            width: 230.0,
                            child: Text(
                              'Select from our partnered merchants to claim vouchers and rewards',
                              style: TextStyle(
                                fontSize: 10,
                                color: ResiklosColors.muted,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          TextField(
                            autocorrect: false,
                            textAlignVertical: TextAlignVertical.center,
                            controller: _textEditingController,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: ResiklosColors.textColor,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                child: Icon(Icons.search),
                                onTap: () {
                                  log("search");
                                  setState(() {
                                    _keyword = _textEditingController.text;
                                    getData();
                                  });
                                },
                              ),
                              hintText: 'Search shop name, category...',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15.0),
                      child: _list1.length == 0
                          ? Container(
                              child: Text(
                                "no data",
                              ),
                              alignment: Alignment.center,
                            )
                          : GridView.extent(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0.0,
                              maxCrossAxisExtent:
                                  (MediaQuery.of(context).size.width / 2) *
                                      ((MediaQuery.of(context).size.width / 2) /
                                          kItemSize),
                              children:
                                  _list1.map<Widget>((MerchantModel merchant) {
                                return GestureDetector(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: kItemSize,
                                        width: kItemSize,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xffd4d4d4),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                merchant.logoUrl ?? ""),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(merchant.name ?? "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _select = merchant;
                                    });
                                    selectVoucher();
                                  },
                                  behavior: HitTestBehavior.opaque,
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: ShopVoucherPage(
              id: 0,
            )),
          ],
        ),
      ),
    );
  }

  void selectVoucher() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              //在这里为了区分，在构建builder的时候将setState方法命名为了setBottomSheetState。
              builder: (context1, setBottomSheetState) {
            return Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        // height: 50,
                        padding: EdgeInsets.only(
                            top: 10, left: 25, right: 25, bottom: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        _select?.name ?? "MERCHANT NAME",
                                        style: TextStyle(
                                            color: color_707070(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    Visibility(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${_select?.industryName} • ${_select?.subIndustryName}",
                                          style: TextStyle(
                                            color: color_d4d4d4(),
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      visible: true,
                                    )
                                  ],
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.close,
                                    color: color_d4d4d4(),
                                    size: 18,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        child: ShopVoucherPage(
                          id: _select?.id ?? 1,
                        ),
                      )
                    ],
                  ),
                ));
          });
        });
  }
}
