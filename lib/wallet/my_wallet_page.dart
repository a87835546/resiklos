import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/utils/color.dart';

class MyWalletPage extends BaseStatefulWidget {
  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _MyWalletPageState();
}

class _MyWalletPageState extends BaseStatefulState<MyWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
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
                        color: mainColor()),
                  ),
                  Container(
                    child: Text(
                      "1234556",
                      style: TextStyle(fontSize: 12, color: mainColor()),
                    ),
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
          ],
        ),
      ),
    );
  }
}
