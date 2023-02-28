import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resiklos/home/setting/setting_request.dart';
import 'package:resiklos/utils/app_singleton.dart';
import 'package:resiklos/utils/request.dart';

class PersonalTopWidget extends StatefulWidget {
  const PersonalTopWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PersonalTopWidgetState();
}

class _PersonalTopWidgetState extends State<PersonalTopWidget> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  ClipRRect(
                    child: Container(
                      height: 136,
                      width: 136,
                      child: FadeInImage.assetNetwork(
                          placeholder: "imgs/verify_kyc_person.png",
                          image: AppSingleton.userInfoModel?.avatar ?? ""),
                    ),
                    borderRadius: BorderRadius.circular(68),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Text(AppSingleton.userInfoModel?.email ?? ""),
                  )
                ],
              ),
            ),
            Positioned(
              child: GestureDetector(
                child: Container(
                  child: Image.asset(
                    "imgs/camera.png",
                    width: 24,
                    height: 24,
                  ),
                ),
                onTap: () async{
                  XFile? file = await _picker.pickImage(source: ImageSource.gallery);
                  var r = await upload(file?.name, file?.path, UploadType.avatar);
                  var result = await uploadAvatarImage(r);
                  if(result){

                  }
                },
              ),
              bottom: 20,
              right: 15,
            )
          ],
        ),
      ),
    );
  }
}
