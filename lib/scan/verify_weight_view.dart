import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class VerifyWeightView extends StatefulWidget {
  final Function(String) input;

  const VerifyWeightView({Key? key, required this.input}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifyWeightViewState();
}

class _VerifyWeightViewState extends State<VerifyWeightView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: mainColor(), width: 1)),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                color: mainColor(),
                height: 35,
                child: Row(
                  children: [
                    Container(
                      child: const Text(
                        "Enter weight",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Container(
                      child: const Text(
                        " Kilo ",
                        style: TextStyle(
                            color: Color(0xff707070),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: TextField(
                          minLines: 1,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "input the plastic weight",
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                              color: mainTitleColor(),
                              fontSize: 12,
                            ),
                          ),
                          showCursor: true,
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            if (v.isEmpty) {
                              return;
                            }
                            widget.input(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              left: (MediaQuery.of(context).size.width - 60) / 2 - 10,
              top: 35 - 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 20,
                  width: 20,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: OverflowBox(
                    maxWidth: 18,
                    maxHeight: 18,
                    child: Image.asset("imgs/logo@2x.png"),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
