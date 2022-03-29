import 'package:flutter/cupertino.dart';
import 'package:resiklos/wallet/my_wallet_list_item.dart';

class MyWalletActivityPage extends StatefulWidget {
  const MyWalletActivityPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyWalletActivityPageState();
}

class _MyWalletActivityPageState extends State<MyWalletActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          MyWalletListItem(),
          MyWalletListItem(),
          MyWalletListItem(),
        ],
      ),
    );
  }
}
