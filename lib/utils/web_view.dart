import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../rk_app_bar.dart';

class CWebView extends StatefulWidget {
  final String title;
  final String url;

  const CWebView({Key? key,required this.title, required this.url})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<CWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: widget.title,),
        body: Builder(
          builder: (context) {
            return WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (url) {
                  print('加载完成=======');
                });
          },
        ));
  }
}
