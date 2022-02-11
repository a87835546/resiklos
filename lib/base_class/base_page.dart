import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:resiklos/utils/app_singleton.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);

  @override
  BaseStatefulState createState() => getState();

  BaseStatefulState getState();
}

abstract class BaseStatefulState<T extends BaseStatefulWidget>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    AppSingleton.currentPage = context;
    AppSingleton.queue?.add(context);
    if(context == AppSingleton.queue?.last){
      AppSingleton.queue?.removeLast();
      AppSingleton.queue?.add(context);
    }
    log("runtime type ---->>>>>>${context == AppSingleton.queue?.last}");
    log("init state queue ----->>>>> ${AppSingleton.queue}");
  }

  ///dispose
  @override
  void dispose() {
    super.dispose();
    AppSingleton.queue?.remove(context);
    log("dispose state queue ----->>>>> ${AppSingleton.queue}");
  }

  ///build
  @override
  Widget build(BuildContext context);

}
