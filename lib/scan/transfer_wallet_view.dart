import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class TransferWalletView extends StatefulWidget {
  const TransferWalletView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransferWalletViewState();
}

class _TransferWalletViewState extends State<TransferWalletView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: mainColor(), width: 1)),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                color: mainColor(),
                height: 35,
                child: Row(
                  children: [
                    Container(
                      child: const Icon(
                        Icons.account_balance_wallet,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      child: const Text(
                        "My RSG Wallet",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "100.0",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: const Text(
                          " RSG ",
                          style: TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            "100.0",
                            style: TextStyle(
                                color: Color(0xff707070),
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 60) / 2 - 10,
              top: 35 - 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 20,
                  width: 20,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: OverflowBox(
                    maxWidth: 18,
                    maxHeight: 18,
                    child: Image.asset("imgs/logo@2x.png"),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
