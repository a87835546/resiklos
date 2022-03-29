import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resiklos/shop/shop_merchant_banner.dart';

class ShopMerchantPage extends StatefulWidget {
  const ShopMerchantPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopMerchantPageState();
}

class _ShopMerchantPageState extends State<ShopMerchantPage> {
  final RefreshController _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SmartRefresher(
      controller: _controller,
      enablePullDown: true,
      enablePullUp: true,
      child: Center(
        child: Container(
          child: const ShopMerchantBanner(),
        ),
      ),
      onRefresh: () {
        _controller.refreshCompleted();
      },
      onLoading: () {
        _controller.loadComplete();
      },
    ));
  }
}
