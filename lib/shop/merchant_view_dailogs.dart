import 'package:flutter/material.dart';

enum ViewDialogsAction { yes, no }

class ViewDialogs {
  static void clickVoucherView(
      BuildContext context, Function goVerifyKYC) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Verification Required"),
          content: const Text(
              'To unlock purchases and transfers, please verify your identity first.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(ViewDialogsAction.no),
              child: const Text('LATER'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ViewDialogsAction.yes);
                goVerifyKYC();
              },
              child: const Text(
                'GO VERIFY',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : ViewDialogsAction.no;
  }
}
