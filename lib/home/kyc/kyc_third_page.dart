import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/kyc/kyc_finished_page.dart';
import 'package:resiklos/home/kyc/kyc_progress_widget.dart';
import 'package:resiklos/home/kyc/kyc_second_two_page.dart';
import 'package:resiklos/home/setting/setting_request.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/request.dart';
import 'package:resiklos/utils/toast.dart';

/// @author :create by yicen
/// date: ${DATE}$
/// email: a87835546@gmail.com
/// desc:

class KycThirdPage extends BaseStatefulWidget {
  const KycThirdPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _KycThirdPageState();
}

class _KycThirdPageState extends BaseStatefulState<KycThirdPage> {
  final ImagePicker _picker = ImagePicker();
  var _image;
  XFile? _path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "PERSONAL VERIFICATION",
      ),
      body: Stack(
        children: [
          KYCProgressWidget(
            type: 3,
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Confirm Identity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  child: const Text(
                    "Take a Selfie",
                    style: TextStyle(color: Color(0xff707070), fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    style: TextStyle(color: Color(0xffd4d4d4), fontSize: 12),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  child: DottedBorder(
                    radius: Radius.circular(10),
                    color: Color(0xffBFBFBF),
                    borderType: BorderType.Circle,
                    child: Container(
                      width: 305,
                      height: 236,
                      child: _image != null
                          ? GestureDetector(
                              child: Container(
                                width: 236,
                                height: 236,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(236 / 2)),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: Image.memory(
                                    _image,
                                    color: Colors.yellowAccent,
                                  ).image,
                                ),
                              ),
                              onTap: () => readData(0))
                          : GestureDetector(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.camera_alt,
                                        size: 33,
                                        color: Color(
                                          0xffD4D4D4,
                                        )),
                                    Text("Facial",
                                        style: TextStyle(
                                            color: Color(0xffD4D4D4),
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                              onTap: () => readData(0)),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        color: mainColor(),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      width: 232,
                      height: 50,
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    if (_path == null) {
                      showErrorText("Please select your selfie photo");
                      return;
                    }
                    log("next");
                    showLoading();
                    var s = await uploadFacial();
                    if (s == true) {
                      NavigatorUtil.push(context, KYCFinishedPage());
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void readData(tag) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    _path = image;
    image?.readAsBytes().then((value) {
      setState(() {
        _image = value;
      });
    });
  }

  Future uploadFacial() async {
    if (_path == null) {
      return false;
    }
    var uploadedImageUrl =
        await upload(_path?.name, _path?.path, UploadType.avatar);

    log("upload image url --->>>>$uploadedImageUrl");
    if (uploadedImageUrl != null) {
      return await uploadFacialImage(uploadedImageUrl);
    } else {
      return false;
    }
  }
}
