import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/toast.dart';
import 'package:resiklos/wallet/import_wallet_completed_page.dart';
import 'package:resiklos/home/import_wallet_progress_widget.dart';
import 'package:resiklos/wallet/setup_wallet_progress_widget.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/wallet/wallet_request.dart';

class ImportWalletPage extends StatefulWidget {
  const ImportWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  final TextEditingController _controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
        bgColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 45, right: 45),
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Image.asset(
                  "imgs/wallet-header.png",
                  width: 120,
                  height: 120,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Import Wallet",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: const Text(
                  "Recover and import wallet using seedphrase",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  alignment: Alignment.center,
                  child: const ImportWalletProgressWidget(
                    step: 1,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                alignment: Alignment.center,
                child: const Text(
                  "Separate each word with a single space. Example: apple banana cat dog…",
                  style: TextStyle(
                      color: Color(0xff707070),
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, top: 15, bottom: 5),
                      child: Text(
                        "12-word seedphrase",
                        style: TextStyle(
                            color: mainTitleColor(),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      height: 135,
                      decoration: BoxDecoration(
                          border: Border.all(color: mainTitleColor(), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)),
                        cursorHeight: 20,
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        controller: _controller1,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                      color: mainColor(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    width: 232,
                    height: 50,
                    child: const Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  if (_controller1.text.length < 3) {
                    showErrorText("Please input correct seedphrase");
                  } else {
                    var res =
                        await importWalletFromSeedPhrase(_controller1.text);
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const ImportWalletCompletedPage();
                    }));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
