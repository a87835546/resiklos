import 'package:flutter/cupertino.dart';
import 'package:resiklos/wallet/my_wallet_list_item.dart';

class MyWalletAssetsPage extends StatefulWidget {
  const MyWalletAssetsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyWalletAssetsPageState();
}

class _MyWalletAssetsPageState extends State<MyWalletAssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          MyWalletListItem(),
          MyWalletListItem(),
        ],
      ),
    );
  }
}
