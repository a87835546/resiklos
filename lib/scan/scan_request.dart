import 'dart:developer';

import 'package:resiklos/utils/http_manager.dart';

Future getPlasticPrice() async {
  var result = await HttpManager.get(
      url: "/wallet/getPrice");
  log("get plastic price result ---->>>> $result");
}