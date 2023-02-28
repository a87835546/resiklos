import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SummaryButtonWidget extends StatefulWidget {
  const SummaryButtonWidget(
      {Key? key, required this.text, required this.icon, required this.click})
      : super(key: key);
  final String text;
  final String icon;
  final Function click;

  @override
  State<StatefulWidget> createState() {
    return _SummaryButtonWidgetState();
  }
}

class _SummaryButtonWidgetState extends State<SummaryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          widget.click();
        },
        // splashColor: Colors.blueGrey.shade50,
        highlightColor: Colors.blueGrey.shade50,
        textColor: Colors.black,
        padding: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
              child: SvgPicture.asset(widget.icon,
                  allowDrawingOutsideViewBox: false, height: 30.0),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xff00a8bf),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
