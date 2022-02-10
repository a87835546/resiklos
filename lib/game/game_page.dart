import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/model/user_info_model.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: Text("Coming Soon"),
      ),
    ));
  }
}
