import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/color.dart';

class HomeTransferSendModeWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool hasInput;
  final TextEditingController? editingController;

  const HomeTransferSendModeWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.hasInput,
      this.editingController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeTransferSendModeWidgetState();
}

class _HomeTransferSendModeWidgetState
    extends State<HomeTransferSendModeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(
                  color: color_707070(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: color_BFBFBF(), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      enabled: widget.hasInput,
                      controller: widget.editingController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.subtitle,
                          contentPadding: EdgeInsets.only(left: 20),
                          hintStyle: TextStyle(
                              color: widget.hasInput
                                  ? color_d4d4d4()
                                  : color_707070(),
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                Visibility(
                  child: GestureDetector(
                    child: Container(
                      width: 30,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: color_d4d4d4(),
                        size: 10,
                      ),
                    ),
                    onTap: () {},
                  ),
                  visible: !widget.hasInput,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
