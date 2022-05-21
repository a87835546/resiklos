import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/bottom_navigationbar.dart';
import 'package:resiklos/home/transactions/transaction_model.dart';
import 'package:resiklos/scan/verify_container_widget.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/date_util.dart';
import 'package:resiklos/wallet/status_icon_widget.dart';

class VerifySuccessfullyPage extends BaseStatefulWidget {
  final num amount;
  final num weight;
  final String address;
  final TransactionModel data;

  const VerifySuccessfullyPage(
      {Key? key,
      required this.amount,
      required this.weight,
      required this.data,
      required this.address})
      : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() =>
      _VerifySuccessfullyPageState();
}

class _VerifySuccessfullyPageState
    extends BaseStatefulState<VerifySuccessfullyPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
                // color: Color(0xff00BEBE),
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("imgs/onboarding-bg.png"),
                    fit: BoxFit.fill)),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                height: 0,
                              ),
                              Container(
                                height: 80,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        child: const Icon(
                                          Icons.save_alt_rounded,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        child: const Icon(
                                          Icons.close,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  "SUCCESSFULLY VERIFIED",
                                  style: TextStyle(
                                    color: mainTitleColor(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "SUCCESSFULLY VERIFIED",
                                  style: TextStyle(
                                    color: mainTitleColor(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        VerifySuccessfullyContainerView(
                            kilos: widget.weight, amount: widget.amount),
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  "REF.NO. ${widget.data.transactionId}",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${addTimeZone(widget.data.createAt ?? "")}",
                                  style: TextStyle(
                                      color: mainTitleColor(), fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 70),
                          child: GestureDetector(
                            child: Container(
                              height: 40,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: mainColor(),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                "BACK TO HOME",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(context,
                                  PageRouteBuilder(pageBuilder: (BuildContext
                                          context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                return CustomBottomNavigationBar();
                              }), (route) => true);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: (MediaQuery.of(context).size.width - 100) / 2,
                    top: 60,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5.0,
                                offset: Offset(0, 4),
                                spreadRadius: 1),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                            width: 100,
                            height: 100,
                            child: statusIcon(status: 2)),
                      ),
                    ))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context, "1");
          return true;
        });
  }
}
