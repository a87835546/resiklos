import 'package:flutter/cupertino.dart';
import 'package:resiklos/wallet/my_wallet_list_item.dart';
import 'package:resiklos/wallet/wallet_model.dart';
import 'package:resiklos/wallet/wallet_request.dart';

class MyWalletAssetsPage extends StatefulWidget {
  const MyWalletAssetsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyWalletAssetsPageState();
}

class _MyWalletAssetsPageState extends State<MyWalletAssetsPage> {
  List<WalletModel> _list = [];

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  void loadingData() async {
    List<WalletModel> res = await fetchAllWallet() as List<WalletModel>;
    setState(() {
      _list = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: _list.map((e) {
          return MyWalletListItem();
        }).toList(),
      ),
    );
  }
}
