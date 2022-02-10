import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpInputWidget extends StatefulWidget {
  final Function(String)? inputValue;
  final String placeholder;
  final String topLabel;
  final bool? isPassword;
  final TextEditingController? controller;

  const SignUpInputWidget(
      {Key? key,
      this.inputValue,
      required this.placeholder,
      required this.topLabel,
      this.controller,
      this.isPassword})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpInputWidgetState();
}

class SignUpInputWidgetState extends State<SignUpInputWidget> {
  var _value = "";
  bool password = false;

  @override
  void initState() {
    password = widget.isPassword ?? false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        cursorColor: Color(0xffC1C2C4),
        controller: widget.controller,
        obscureText: password,
        style: const TextStyle(
          color: Colors.black45,
          fontSize: 12,
        ),
        decoration: InputDecoration(
            suffixIcon: widget.isPassword == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        password = !password;
                      });
                    },
                    child: Icon(Icons.remove_red_eye_outlined),
                  )
                : null,
            labelText: widget.topLabel,
            labelStyle: TextStyle(color: Color(0xff707070)),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 1),
              borderRadius: BorderRadius.circular(25),
            ),
            // border: InputBorder.none,
            hintText: widget.placeholder,
            hintStyle: const TextStyle(color: Color(0xffC1C2C4)),
            contentPadding: const EdgeInsets.only(left: 20, bottom: 10)),
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          if (widget.inputValue != null) {
            widget.inputValue!(value);
          }
        },
        onEditingComplete: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          FocusManager.instance.primaryFocus?.unfocus();
          FocusScope.of(context).requestFocus(FocusScopeNode());
          if (widget.inputValue != null) {
            widget.inputValue!(_value);
          }
        },
      ),
    );
  }

  void update(value) {
    log("update value $value");
    setState(() {
      widget.controller?.text = value;
      _value = value;
    });
  }
}
