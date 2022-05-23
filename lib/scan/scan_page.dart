import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:recognition_qrcode/recognition_qrcode.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/scan/transfer_page.dart';
import 'package:resiklos/scan/verify_proceed_page.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/toast.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String? code;
  QRViewController? controller;
  bool _isCan = true;
  bool _isVerify = true;

  @override
  void reassemble() {
    log("reassemble---->>>>>>>>");
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: CustomAppBar(
        title: '',
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: <Widget>[
            Expanded(flex: 7, child: _buildQrView(context)),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                            child: GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.qr_code_scanner_outlined,
                                        size: 20,
                                        color: mainColor(),
                                      ),
                                    ),
                                    Text(
                                      'TRANSFER',
                                      style: TextStyle(
                                          color: mainTitleColor(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                log("点击transfer");
                                setState(() {
                                  _isVerify = false;
                                });
                                controller?.resumeCamera();
                              },
                            ),
                            visible: false,
                          ),
                          GestureDetector(
                            child: Container(
                              height: 80,
                              width: 80,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.qr_code_scanner_outlined,
                                      size: 20,
                                      color: mainColor(),
                                    ),
                                  ),
                                  Text(
                                    'VERIFY',
                                    style: TextStyle(
                                        color: mainTitleColor(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              log("点击verify");
                              setState(() {
                                _isVerify = true;
                              });
                              controller?.resumeCamera();
                            },
                          )
                        ],
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.white70, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.image,
                                size: 16,
                                color: Colors.white70,
                              ),
                              Text(
                                "IMPORT FROM PHOTOS",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white70),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          final picker = ImagePicker();
                          picker
                              .pickImage(source: ImageSource.gallery)
                              .then((value) {
                            log(" value path --->>>${value?.path}");
                            RecognitionQrcode.recognition(value?.path)
                                .then((result) {
                              log("RecognitionQrcode: $result");
                              setState(() {
                                code = result["value"];
                                _isVerify = true;
                              });
                              Navigator.push(
                                  context,
                                  _createRoute(Tween(
                                      begin: Offset(1.0, 0),
                                      end: Offset.zero)));
                            }).catchError((e) {
                              log("RecognitionQrcode error: $e");
                              showErrorText("The qr code parsing failed");
                            });
                          });
                        },
                        behavior: HitTestBehavior.opaque,
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: mainColor(),
          overlayColor: Colors.grey,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 4,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((Barcode scanData) async {
      if (code != null && _isCan) {
        _isCan = false;
        controller.pauseCamera();
        Navigator.push(context,
                _createRoute(Tween(begin: Offset(1.0, 0), end: Offset.zero)))
            .then((value) {
          if (value == true || value == "1") {
            setState(() {
              this.controller = controller;
            });
            controller.resumeCamera();
          }
        });
        // 500 毫秒内 不能多次点击
        Future.delayed(const Duration(milliseconds: 500), () {
          _isCan = true;
        });
      } else {
        controller.resumeCamera();
      }
      setState(() {
        code = scanData.code;
        log("result ------>>>>${code}");
      });
    });
  }

  Route _createRoute(Tween<Offset> tween) {
    return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return _isVerify
              ? VerifyProceedPage(
                  address: code ?? "",
                )
              : TransferPage(
                  address: code ?? "",
                );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                animation.drive(tween.chain(CurveTween(curve: Curves.ease))),
            child: child,
          );
        });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
