import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/web_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeArticlesView extends StatefulWidget {
  final bool isResiklos;
  const HomeArticlesView({Key? key,required this.isResiklos}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeArticlesViewState();
}

class _HomeArticlesViewState extends State<HomeArticlesView> {
  @override
  Widget build(BuildContext context) {
    var url = widget.isResiklos ? "https://resiklos.com/what-is-resiklos" :"https://resiklos.com/importance-of-resiklos";
    var title = widget.isResiklos ? "What is Resiklos?" :"Importance of Resiklos";
    var image_url = widget.isResiklos ? "imgs/what-is-resiklos.png" : "imgs/importance-of-resiklos.png";
    return GestureDetector(
      onTap: () async {
        NavigatorUtil.push(context, CWebView(title: title, url: url));
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withAlpha(80),
                blurRadius: 5.0,
                offset: Offset(0, 4),
                spreadRadius: 1),
          ],
        ),
        // clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            Container(
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15, top: 20),
                        alignment: Alignment.topLeft,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:const TextStyle(
                              color: Color(0xff707070),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, top: 0,right: 130),
                        alignment: Alignment.topLeft,
                        child: Text(
                          url,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Color(0xffD4D4D4), fontSize: 10),
                        ),
                      ),
                    ],
                  )),
                  Container(
                      height: 50,
                      padding: EdgeInsets.only(right: 134),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              "READ MORE",
                              style: TextStyle(
                                  color: Color(0xff0CC9BE),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                          Container(
                            child:const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff0CC9BE),
                              size: 16,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
                child: Container(
                  height: 100,
                  width: 124,
                  color: Colors.transparent,
                  child: OverflowBox(
                    maxWidth: 124,
                    maxHeight: 124,
                    child: Image.asset(image_url),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}
