import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/http_manager.dart';
import 'package:resiklos/utils/request.dart';

class SettingPage extends BaseStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _SettingPageState();
}

class _SettingPageState extends BaseStatefulState<SettingPage> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    log("id --->>>>>${AppSingleton.userInfoModel?.id}");
    return Scaffold(
      appBar: CustomAppBar(
        title: "Settings",
      ),
      body: Center(
        child: Column(
          children: [
            Text("Settings"),
            ElevatedButton(
                onPressed: () async {
                  selectImage();
                },
                child: Text("测试上传图片"))
          ],
        ),
      ),
    );
  }

  void selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    String path = image?.path ?? "";
    var uploadedImageUrl = await upload(image?.name, path, UploadType.avatar);
    log("upload image url --->>>>$uploadedImageUrl");
    if (uploadedImageUrl != null) {
      uploadImage(uploadedImageUrl);
    }
  }

  void uploadImage(url) async {
    var result = await HttpManager.post(
        url: "/user/uploadAvatar",
        params: {"id": AppSingleton.userInfoModel?.id, "url": url});
    log("upload image result ---->>>> $result");
  }
}
