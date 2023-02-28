import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showToast(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      backgroundColor: Colors.blueGrey.shade600.withOpacity(0.8),
      content: Text(text),
      elevation: 0,
      duration: const Duration(milliseconds: 800),
      action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
