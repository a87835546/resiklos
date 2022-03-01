import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/home/home_top_container_widget.dart';

class HomeButtonWidget extends StatefulWidget {
  final HomeButtonModel? model;
  final Function? click;
  const HomeButtonWidget({Key? key,required this.model,this.click}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeButtonWidgetState();
}

class _HomeButtonWidgetState extends State<HomeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(null != widget.click){
          widget.click!();
        }
      },
      child: Container(
        child: Column(
          children: [
            Container(
              child: Icon(
               widget.model?.url??Icons.send_sharp,
                size: 40,
                color:Color(0xff00A6BE),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                widget.model?.title??"QR",
                style: TextStyle(
                    color: Color(0xff00A6BE),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            )
          ],
        ),
      ),
      behavior: HitTestBehavior.translucent,
    );
  }
}
