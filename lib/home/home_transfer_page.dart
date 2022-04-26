import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/home_transfer_send_mode_widget.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/toast.dart';
import 'package:resiklos/utils/verify_util.dart';

class HomeTransferPage extends StatefulWidget {
  const HomeTransferPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTransferPageState();
}

class _HomeTransferPageState extends State<HomeTransferPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _balance = "0";
  String _inputValue = "0";

  @override
  void initState() {
    super.initState();
    getAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 70,
            padding: EdgeInsets.only(left: 18, right: 18),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Send RP",
                    style: TextStyle(
                        color: color_707070(),
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Send RSG to Resiklos account",
                    style: TextStyle(
                        color: color_d4d4d4(),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: HomeTransferSendModeWidget(
                    title: "Send Mode",
                    subtitle: "Email",
                    hasInput: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: HomeTransferSendModeWidget(
                    title: "Email",
                    subtitle: "Resiklos account email",
                    editingController: _emailController,
                    hasInput: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: HomeTransferSendModeWidget(
                    title: "Amount",
                    subtitle: "Input your transfer amount",
                    editingController: _amountController,
                    hasInput: true,
                    onChanged: (v) {
                      setState(() {
                        _inputValue = v;
                      });
                    },
                  ),
                ),
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Available Balance",
                          style: TextStyle(
                              color: color_707070(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        child: Text(
                          "$_balance RP",
                          style: TextStyle(
                              color: color_707070(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: HomeTransferSendModeWidget(
                    title: "Note(Optional)",
                    subtitle: "Add a note for the recipient",
                    editingController: _noteController,
                    hasInput: true,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Total Amount",
                              style: TextStyle(
                                  color: color_d4d4d4(), fontSize: 12),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$_inputValue RP",
                              style: TextStyle(
                                  color: color_707070(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 100,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "No Fees",
                              style: TextStyle(
                                  color: color_707070(), fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: mainColor(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
                        child: const Text(
                          "Send",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        transfer();
                      },
                    )
                  ],
                ),
              ),
              height: 100,
              width: MediaQuery.of(context).size.width,
            ),
            left: 0,
            bottom: 0,
          )
        ],
      ),
    );
  }

  void getAmount() async {
    var res = await HttpManager.get(
        url: "wallet/balance?email=${AppSingleton.userInfoModel?.email}");
    log("balance --->>>$res");
    try {
      setState(() {
        _balance = res["data"]["rpBalance"];
      });
    } catch (e) {
      log("获取余额错误");
    }
  }

  void transfer() async {
    int amount =
        int.parse(_amountController.text == "" ? "0" : _amountController.text);
    log("message--->>>${amount}");
    if (!VerifyUtil.isEmail(_emailController.text)) {
      showErrorText("Please input correct email");
      return;
    }
    if (amount == 0) {
      showErrorText("Please input transfer correct amount");
      return;
    }
    if (amount > num.parse(_balance)) {
      showErrorText(
          "Please input transfer correct amount,your available balance has $_balance");
      return;
    }

    Map<String, dynamic> temp = {
      "email": AppSingleton.userInfoModel?.email,
      "toEmail": _emailController.text,
      "amount": _amountController.text,
      "name": AppSingleton.userInfoModel?.nickName,
      "note": _noteController.text,
    };
    var res = await HttpManager.post(url: "wallet/transferRP", params: temp);
    log("transfer --->>>$res");
  }
}
