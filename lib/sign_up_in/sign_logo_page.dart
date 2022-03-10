import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignLogoPage extends StatelessWidget {
  final String? url;
  const SignLogoPage({Key? key,this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withAlpha(80),
                blurRadius: 5.0,
                offset: Offset(0, 5))
          ]),
      child:  Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
        child: Image(
          image: AssetImage( url??"imgs/logo@2x.png"),
          width: 80,
          height: 80,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
