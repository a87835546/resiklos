import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/home_page.dart';
import 'package:resiklos/home/setting/setting_request.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/scan/transfer_page.dart';
import 'package:resiklos/sign_up_in/sign_button.dart';
import 'package:resiklos/sign_up_in/sign_request.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/color.dart';
import 'package:resiklos/utils/request.dart';

class SettingPage extends BaseStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _SettingPageState();
}

class _SettingPageState extends BaseStatefulState<SettingPage> {
  final ImagePicker _picker = ImagePicker();
  final List<SettingModel> _list = [
    SettingModel("About", TransferPage()),
    SettingModel("About", TransferPage()),
    SettingModel("About", TransferPage()),
    SettingModel("About", TransferPage()),
    SettingModel("About", TransferPage()),
    SettingModel("Version", TransferPage()),
    SettingModel("Notification", TransferPage()),
    SettingModel("About", TransferPage()),
  ];

  @override
  Widget build(BuildContext context) {
    log("id --->>>>>${AppSingleton.userInfoModel?.id}");
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Settings",
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListView(
              children: _list.map((e) {
                return GestureDetector(
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(
                      e.title,
                      style: TextStyle(color: mainTitleColor(), fontSize: 14),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 16,
                      color: mainColor(),
                    ),
                  ),
                  onTap: () {
                    log("click setting index ---->>>>${e.title}");
                  },
                );
              }).toList(),
              shrinkWrap: true,
            ),
            const SizedBox(
              height: 30,
            ),
            SignButton(
                disable: true,
                title: "LOG OUT",
                click: () async {
                  SignRequest.logout(context);
                }),
            const Text("Settings"),
            ElevatedButton(
                onPressed: () async {
                  selectImage();
                },
                child: Text("测试上传图片")),
            ElevatedButton(
                onPressed: () async {
                  deleteAccount();
                },
                child: Text("delete account")),
            ElevatedButton(
                onPressed: () async {
                  getUserProfile();
                },
                child: Text("get users profiles")),
            ElevatedButton(
                onPressed: () async {
                  getUserProfile();
                },
                child: Text("create inner wallet address")),
            ElevatedButton(
                onPressed: () async {
                  getUserProfile();
                },
                child: Text("create wallet address")),
            ElevatedButton(
                onPressed: () async {
                  getUserProfile();
                },
                child: Text("transfer rp")),
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
      await uploadImage(uploadedImageUrl,false,0);
    }
  }
}

class SettingModel {
  String title;
  Widget? target;

  SettingModel(this.title, this.target);
}
