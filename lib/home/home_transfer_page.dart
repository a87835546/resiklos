import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:resiklos/home/home_transfer_send_mode_widget.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/TokenTx.dart';
import 'package:resiklos/utils/Tx.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/cache.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/event_bus_util.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/toast.dart';
import 'package:resiklos/utils/verify_util.dart';
import 'package:resiklos/wallet/abi/contracts.dart';
import 'package:resiklos/wallet/my_wallet_page.dart';
import 'package:resiklos/wallet/wallet_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:web3dart/web3dart.dart';
import 'package:web3dart/src/crypto/formatting.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

class HomeTransferPage extends StatefulWidget {
  final bool isRp;
  final WalletType type;

  const HomeTransferPage({Key? key, required this.isRp, required this.type})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTransferPageState();
}

class _HomeTransferPageState extends State<HomeTransferPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _balance = "0";
  String _inputValue = "0";
  String _title = "Email";
  String _modeTitle = "Email";
  double? _gasFee;
  double? _bnbBalance;

  @override
  void initState() {
    super.initState();
    if (!widget.isRp) {
      loadBalance();
      getGasFee();
      setState(() {
        _title = "Wallet Address";
      });
    } else {
      getAmount();
    }

    if (widget.type == WalletType.BNB) {
      setState(() {
        _modeTitle = "BSC";
      });
    } else if (widget.type == WalletType.USDT) {
      setState(() {
        _modeTitle = "BSC BEP-20";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool disable = widget.isRp
        ? false
        : (_bnbBalance.toString() == "0" || _balance == "0");
    return Scaffold(
      appBar: const CustomAppBar(
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
                    "Send ${widget.type.name}",
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
                    "Send ${widget.type.name} to your account",
                    style: TextStyle(
                        color: color_d4d4d4(),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: HomeTransferSendModeWidget(
                      title: "${widget.type == WalletType.BNB || widget.type == WalletType.USDT ? "Network" : "Send"} Mode",
                      subtitle: widget.type == WalletType.BNB ||
                              widget.type == WalletType.USDT
                          ? _modeTitle
                          : _title,
                      hasInput: false,
                      click: () {
                        // selectType(context);
                        selectType1();
                      },
                    ),
                  ),
                  visible: true,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: HomeTransferSendModeWidget(
                    title: _title,
                    subtitle: widget.isRp ? "Resiklos account $_title" : _title,
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
                          "$_balance ${widget.type.name}",
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
          Visibility(
            child: Positioned(
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
                              width: 200,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Total Amount",
                                style: TextStyle(
                                    color: color_d4d4d4(), fontSize: 12),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 200,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "$_inputValue ${widget.type.name}",
                                style: TextStyle(
                                    color: color_707070(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 200,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.isRp
                                    ? "No Fees"
                                    : "$_gasFee BNB Gas fee",
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
                            color: disable
                                ? mainColor().withOpacity(0.2)
                                : mainColor(),
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
                          if (disable) {
                            return;
                          }
                          if (widget.type == WalletType.RP) {
                            transferRP();
                          } else if (widget.type == WalletType.RSG ||
                              widget.type == WalletType.RSGT) {
                            transferRSG();
                          } else if (widget.type == WalletType.BNB) {
                            transferBNB();
                          } else if (widget.type == WalletType.USDT) {
                            transferUSDT();
                          }
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
            ),
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
          )
        ],
      ),
    );
  }

  void selectType1() {
    if (widget.type != WalletType.RSG) {
      return;
    }
    List title = ["Email", "Id"];
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              //在这里为了区分，在构建builder的时候将setState方法命名为了setBottomSheetState。
              builder: (context1, setBottomSheetState) {
            return Container(
              color: Colors.transparent,
              height: 170,
              padding: EdgeInsets.only(left: 15),
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  Container(
                    height: 40,
                    child: Text(
                        widget.isRp ? "Send Mode" : "Send via crypto network,"),
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 16,
                          color: color_707070(),
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title.first,
                            style: TextStyle(color: color_707070()),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _title = title.first;
                      });
                      Navigator.of(context).pop(true);
                    },
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.perm_identity_outlined,
                          size: 16,
                          color: color_707070(),
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title.last,
                            style: TextStyle(color: color_707070()),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _title = title.last;
                      });
                      Navigator.of(context).pop(true);
                    },
                  ),
                  Container(
                    height: 50,
                  )
                ],
              ),
            );
          });
        });
  }

  void getAmount() async {
    var res = await HttpManager.get(
        url: "wallet/balance?email=${AppSingleton.userInfoModel?.email}");
    log("balance --->>>$res");
    try {
      if (mounted && widget.isRp) {
        setState(() {
          _balance = res["data"]["rpBalance"];
        });
      }
    } catch (e) {
      log("获取余额错误");
    }
  }

  void transferRP() async {
    int amount =
        int.parse(_amountController.text == "" ? "0" : _amountController.text);
    log("message--->>>${amount}");
    if (!VerifyUtil.isEmail(_emailController.text) && _title == "Email") {
      showErrorText("Please input correct email");
      return;
    }
    if (_title == "Id" && _emailController.text.isEmpty) {
      showErrorText("Please input correct user id");
      return;
    }
    if (amount == 0) {
      showErrorText("Please input transfer correct amount");
      return;
    }
    if (amount > num.parse(_balance)) {
      showErrorText(
          "Please input valid amount,your available balance is $_balance");
      return;
    }

    Map<String, dynamic> temp = {
      "email": AppSingleton.userInfoModel?.email,
      "toEmail": _title == "Email"
          ? _emailController.text
          : AppSingleton.userInfoModel?.id,
      "amount": _amountController.text,
      "name": AppSingleton.userInfoModel?.nickName,
      "note": _noteController.text,
    };
    var res = await HttpManager.post(url: "wallet/transferRP", params: temp);
    log("transfer --->>>$res");
    if (res["code"] == 200) {
      showText("Transfer RP Success");
      EventBusUtil.fire(RefreshRpEvent());
      Navigator.of(context).pop();
    } else {
      showText("Transfer RP Fail ${res["message"]}");
    }
  }

  void loadBalance() {
    if (AppSingleton.userInfoModel?.walletAddress != null ||
        AppSingleton.userInfoModel?.walletAddress != "") {
      TokenTx.getBalances(AppSingleton.userInfoModel?.walletAddress ?? "")
          .then((value) {
        log("balance 0--->>>$value");

        for (var element in value) {
          if (element.symbol == WalletType.RSGT.name) {
            log("rsgt ---->>>${element.balance}");
            if (mounted) {
              setState(() {
                log("rsg balance ---->>$_balance");
                try {
                  _balance = element.balance.toString();
                } catch (e) {
                  log("err--->>>$e");
                }
              });
            }
          }
        }
      });
      Tx.getBalance(AppSingleton.userInfoModel?.walletAddress ?? "")
          .then((value) {
        setState(() {
          _bnbBalance = value;
          log("bnb balance ---<>>>$_bnbBalance");
        });
      });
    }
  }

  void getGasFee() async {
    double gasFee = await Blockchain.estimateGasFee();
    log("gas fee --->>$gasFee");
    setState(() {
      _gasFee = gasFee;
    });
  }

  void transferRSG() async {
    showLoading(title: "Processing transfer. Please wait");
    double amount = double.parse(
        _amountController.text == "" ? "0" : _amountController.text);
    log("message--->>>${amount}");
    String address = _emailController.text;
    if (amount == 0) {
      showErrorText("Please input transfer correct amount");
      return;
    }
    if (amount > num.parse(_balance)) {
      showErrorText(
          "Please input valid amount,your available balance is $_balance");
      return;
    }

    Blockchain.loadWallet().then((value) {
      Blockchain.transferBep20Token(
              address, Bep20Token.rsgt, amount.toString(), value)
          .then((tx) {
        log("tx id --->>>$tx");
        completeTransferRSG(tx, amount.toString(), _emailController.text,
                note: _noteController.text)
            .then((value) {
          showText("Transfer success");

          Navigator.of(context).pop();
          log("transfer result--->>>$value");
        });
        showText("Transfer success");
      }).catchError((e) {
        log("transfer  error --->>>${e}");
        showErrorText("Transfer failed");
      });
    }).catchError((e) {
      log("load wallet error --->>>${e}");
      showErrorText("Transfer RSG failed");
    });
  }

  void transferBNB() async {
    showLoading(title: "Processing transfer. Please wait");
    double amount = double.parse(
        _amountController.text == "" ? "0" : _amountController.text);
    log("message--->>>${amount}");
    String address = _emailController.text;
    if (amount == 0) {
      showErrorText("Please input transfer correct amount");
      return;
    }
    if (amount > num.parse(_balance)) {
      showErrorText(
          "Please input valid amount,your available balance is $_balance");
      return;
    }

    Blockchain.loadWallet().then((value) {
      Blockchain.transferCoin(address, amount.toString(), value).then((tx) {
        log("tx id --->>>$tx");
        completeTransferRSG(tx, amount.toString(), _emailController.text,
                note: _noteController.text)
            .then((value) {
          showText("Transfer success");

          Navigator.of(context).pop();
          log("transfer result--->>>$value");
        });
        showText("Transfer success");
      }).catchError((e) {
        log("transfer  error --->>>${e}");
        showErrorText("Transfer BNB failed");
      });
    }).catchError((e) {
      log("load wallet error --->>>${e}");
      showErrorText("Transfer BNB failed");
    });
  }

  void transferUSDT() async {
    showLoading(title: "Processing transfer. Please wait");
    double amount = double.parse(
        _amountController.text == "" ? "0" : _amountController.text);
    log("message--->>>${amount}");
    String address = _emailController.text;
    if (amount == 0) {
      showErrorText("Please input transfer correct amount");
      return;
    }
    if (amount > num.parse(_balance)) {
      showErrorText(
          "Please input valid amount,your available balance is $_balance");
      return;
    }

    Blockchain.loadWallet().then((value) {
      Blockchain.transferBep20Token(
              address, Bep20Token.usdt, amount.toString(), value)
          .then((tx) {
        log("tx id --->>>$tx");
        completeTransferRSG(tx, amount.toString(), _emailController.text,
                note: _noteController.text)
            .then((value) {
          showText("Transfer success");

          Navigator.of(context).pop();
          log("transfer result--->>>$value");
        });
        showText("Transfer success");
      }).catchError((e) {
        log("transfer  error --->>>${e}");
        showErrorText("Transfer USDT failed");
      });
    }).catchError((e) {
      log("load wallet error --->>>${e}");
      showErrorText("Transfer USDT failed");
    });
  }
}
