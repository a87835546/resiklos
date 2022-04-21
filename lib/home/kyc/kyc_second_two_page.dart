import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/kyc/kyc_progress_widget.dart';
import 'package:resiklos/home/kyc/kyc_third_page.dart';
import 'package:resiklos/home/setting/setting_request.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/request.dart';
import 'package:resiklos/utils/toast.dart';

/// @author :create by yicen
/// date: ${DATE}$
/// email: a87835546@gmail.com
/// desc:

class KycSecond2Page extends BaseStatefulWidget {
  final int? type;

  const KycSecond2Page({Key? key, this.type}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _KycSecond2PageState();
}

class _KycSecond2PageState extends BaseStatefulState<KycSecond2Page> {
  var _image;
  XFile? _path;
  XFile? _path1;
  var _image1;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "PERSONAL VERIFICATION",
      ),
      body: Stack(
        children: [
          KYCProgressWidget(
            type: 2,
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
                      'Personal Information',
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
                    "Take a Photo of your ID",
                    style: TextStyle(color: Color(0xff707070), fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Please make sure that every details of the ID document is clearly visible.",
                    style: TextStyle(color: Color(0xffd4d4d4), fontSize: 12),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [0, 1].map((e) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        child: DottedBorder(
                          radius: Radius.circular(10),
                          color: Color(0xffBFBFBF),
                          borderType: BorderType.RRect,
                          child: Container(
                            width: 305,
                            height: 166,
                            child: _image != null && e == 0 ||
                                    _image1 != null && e == 1
                                ? GestureDetector(
                                    child: Container(
                                      child: Image.memory(
                                          e == 0 ? _image : _image1),
                                    ),
                                    onTap: () => readData(e))
                                : GestureDetector(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.camera_alt,
                                              size: 33,
                                              color: Color(
                                                0xffD4D4D4,
                                              )),
                                          Text(e == 1 ? "BACK" : "FONT",
                                              style: const TextStyle(
                                                  color: Color(0xffD4D4D4),
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    onTap: () => readData(e)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        color: _image != null && _image1 != null
                            ? mainColor()
                            : mainColor().withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      width: 232,
                      height: 50,
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: _image != null && _image1 != null
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    if (_image != null && _image1 != null) {
                      showLoading();
                      log("next");
                      var r = await uploadImage(widget.type ?? 0);
                      log("upload pic state ----->>>>>>>$r");
                      if (r == true) {
                        NavigatorUtil.push(context, KycThirdPage());
                      } else {
                        showErrorText("upload id error");
                      }
                    } else {
                      showErrorText("Please select your photos");
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

  Future uploadImage(type) async {
    var font = await upload(_path?.name, _path?.path, UploadType.avatar);
    var back = await upload(_path1?.name, _path1?.path, UploadType.avatar);

    log("upload image url --->>>>$font");
    if (font != null && back != null) {
      return await uploadIDImage(font, back, type);
    } else {
      return false;
    }
  }

  void readData(tag) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    tag == 0 ? _path = image : _path1 = image;
    image?.readAsBytes().then((value) {
      setState(() {
        tag == 0 ? _image = value : _image1 = value;
      });
    });
  }
}
