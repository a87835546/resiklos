import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class ShopMerchantBanner extends StatefulWidget {
  const ShopMerchantBanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopMerchantBannerState();
}

class _ShopMerchantBannerState extends State<ShopMerchantBanner> {
  List _list = [];

  @override
  void initState() {
    super.initState();
    getDate();
  }

  void getDate() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Swiper(
        itemCount: _list.length,
        axisDirection: AxisDirection.right,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: FadeInImage.assetNetwork(
                  placeholder: "placeholder",
                  image: ""));
        },
      ),
    );
  }
}
