import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/transactions/transaction_list.dart';
import 'package:resiklos/home/transactions/transaction_model.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/date_util.dart';

class TransactionDetailPage extends StatefulWidget {
  final TransactionModel model;
  final WalletTransactionType type;

  const TransactionDetailPage(
      {Key? key, required this.type, required this.model})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Transfer Detail",
      ),
      body: Container(
        // padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TransactionDetailItem(
              title: "Transaction ID:",
              subTitle: "${widget.model.transactionId}",
            ),
            Visibility(
              child: TransactionDetailItem(
                title: "Transaction Hash:",
                subTitle: "${widget.model.txId}",
              ),
              visible: widget.type == WalletTransactionType.bep20,
            ),
            TransactionDetailItem(
              title: "Recipient Address:",
              subTitle:
                  "${widget.model.receiveAddress ?? AppSingleton.userInfoModel?.rpWalletAddress}",
            ),
            Visibility(
              child: TransactionDetailItem(
                title: "Recipient Name:",
                subTitle: "${widget.model.receivedUserName}",
              ),
              visible: widget.type != WalletTransactionType.bep20,
            ),
            TransactionDetailItem(
              title: "Source Address:",
              subTitle: "${widget.model.transferAddress ?? ""}",
            ),
            TransactionDetailItem(
              title: "Source Name:",
              subTitle: "${widget.model.transferUserName ?? "Resiklos"}",
            ),
            TransactionDetailItem(
              title: "Transfer Amount:",
              subTitle:
                  "${widget.model.point} ${widget.type == WalletTransactionType.bep20 ? "RSG" : "RP"}",
              color: (widget.model.receiveAddress !=
                      AppSingleton.userInfoModel?.rpWalletAddress
                  ? Colors.redAccent
                  : Colors.greenAccent),
            ),
            TransactionDetailItem(
              title: "Transfer Time:",
              subTitle: "${addTimeZone(widget.model.createAt??"")}",
            ),
            Visibility(
              child: TransactionDetailItem(
                title: "Transfer Note:",
                subTitle: "${widget.model.note}",
              ),
              visible: !(widget.model.note == "" || widget.model.note == null),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionDetailItem extends StatelessWidget {
  String title;
  String subTitle;
  Color? color;

  TransactionDetailItem(
      {Key? key, required this.title, required this.subTitle, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              child: Text(
                title,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              alignment: Alignment.centerRight,
            ),
            flex: 2,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                subTitle,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500, color: color),
              ),
            ),
            flex: 5,
          )
        ],
      ),
    );
  }
}
