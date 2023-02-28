import 'dart:developer';

import 'package:amazon_s3_cognito/amazon_s3_cognito.dart';
import 'package:amazon_s3_cognito/aws_region.dart';
import 'package:amazon_s3_cognito/image_data.dart';

class Request {}

enum UploadType { avatar, id, selfie }

Future upload(imageName, path, UploadType type) async {
  log("upload type ---->>>>${type.name}");
  String BUCKET_NAME = "rk-db";
  String IDENTITY_POOL_ID =
      "ap-southeast-1:64ff2184-0ce0-4704-8ee8-71024a97f7c4";
  List<String> _temp = imageName.split("/");
  log("image name ---->>>>> $imageName path---- >>>>${_temp.last}");

  ImageData im = ImageData("${type.name}/${_temp.last}", "${path}");
  String? uploadedImageUrl = await AmazonS3Cognito.upload(
    BUCKET_NAME,
    IDENTITY_POOL_ID,
    AwsRegion.AP_SOUTHEAST_1,
    AwsRegion.AP_SOUTHEAST_1,
    im,
  );
  return Future.value(uploadedImageUrl);
}
