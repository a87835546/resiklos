import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resiklos/shop/shop_vouchers_page.dart';
import 'package:resiklos/utils/constants.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
    with SingleTickerProviderStateMixin {
  List<Merchant> merchants = <Merchant>[
    Merchant(
      image: 'https://picsum.photos/id/237/200/300',
      title: 'Chennai',
    ),
    Merchant(
      image: 'https://picsum.photos/id/235/200/300',
      title: 'Tanjore',
    ),
    Merchant(
      image: 'https://picsum.photos/id/1000/200/300',
      title: 'Tanjore',
    ),
    Merchant(
      image: 'https://picsum.photos/id/1001/200/300',
      title: 'Tanjore',
    ),
    Merchant(
      image: 'https://picsum.photos/id/789/200/300',
      title: 'Tanjore',
    ),
    Merchant(
      image: 'https://picsum.photos/id/542/200/300',
      title: 'Pondicherry',
    ),
    Merchant(
      image: 'https://picsum.photos/id/123/200/300',
      title: 'Chennai',
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              foregroundColor: Colors.blueGrey,
              pinned: false,
              floating: false,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: Container(
                height: 1000,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/400/400'),
                      fit: BoxFit.cover),
                ),
              ),
              bottom: TabBar(
                indicatorWeight: 5,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding:
                    EdgeInsets.only(bottom: 5.0, left: 20, right: 20),
                tabs: const <Tab>[
                  Tab(text: 'Merchants'),
                  Tab(text: 'Vouchers'),
                ],
                controller: _tabController,
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
                  debugPrint('hello');
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        children: [
                          Text(
                            'PARTNER MERCHANTS',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          SizedBox(
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
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: ResiklosColors.textColor,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                child: Icon(Icons.search),
                                onTap: (){
                                  log("search");
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
                      child: GridView.extent(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10.0,
                        maxCrossAxisExtent:
                            (MediaQuery.of(context).size.width / 2),
                        children: merchants.map<Widget>((Merchant merchant) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 120.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    width: 1.0,
                                    color: const Color(0xffd4d4d4),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(merchant.image ?? ""),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(merchant.title ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(child: ShopVoucherPage()),
          ],
        ),
      ),
    );
  }
}

class Merchant {
  Merchant({
    this.id,
    this.image,
    this.title,
  });

  final String? id;
  final String? image;
  final String? title;
}
