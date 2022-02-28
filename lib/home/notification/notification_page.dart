import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/rk_app_bar.dart';

class NotificationPage extends BaseStatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _NotificationPageState();
}

class _NotificationPageState extends BaseStatefulState<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notifications",
      ),
      body: Text("Notifications"),
    );
  }
}
