import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class VerifyConfirmAmountView extends StatefulWidget {
  final num weight;
  const VerifyConfirmAmountView({Key? key,required this.weight}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifyConfirmAmountViewState();
}

class _VerifyConfirmAmountViewState extends State<VerifyConfirmAmountView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: mainColor(), width: 1)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Text(
                      widget.weight.toStringAsFixed(2),
                      style:const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: mainColor(),
                    alignment: Alignment.center,
                    child: const Text(
                      "Weight (Gram)",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
        Positioned(
            left: (MediaQuery.of(context).size.width - 60) / 2 - 10,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 20,
                width: 20,
                color: Colors.white,
                alignment: Alignment.center,
                child: OverflowBox(
                  maxWidth: 15,
                  maxHeight: 15,
                  child: Image.asset("imgs/logo@2x.png",),
                ),
              ),
            ))
      ],
    );
  }
}
