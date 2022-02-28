import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/model/user_info_model.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: Text("Coming Soon"),
      ),
    ));
  }
}
