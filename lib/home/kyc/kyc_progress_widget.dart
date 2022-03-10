import 'package:flutter/cupertino.dart';
import 'package:resiklos/utils/color.dart';

class KYCProgressWidget extends StatefulWidget {
  final int type;

  const KYCProgressWidget({Key? key, required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KYCProgressWidgetState();
}

class _KYCProgressWidgetState extends State<KYCProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: mainColor(),
            ),
            flex: widget.type,
          ),
          Expanded(
            child: Container(
              color: mainTitleColor(),
            ),
            flex: 3 - widget.type,
          ),
        ],
      ),
    );
  }
}
