import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/rk_app_bar.dart';

class SettingPage extends BaseStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _SettingPageState();
}

class _SettingPageState extends BaseStatefulState<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Settings",
      ),
      body: Text("Settings"),
    );
  }
}
