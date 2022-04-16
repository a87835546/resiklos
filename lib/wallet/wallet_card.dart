import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resiklos/utils/app_singleton.dart';

class WalletCard extends StatefulWidget {
  final num rsg;
  const WalletCard({Key? key,required this.rsg}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: // wallet-card
          Stack(
        children: <Widget>[
          SizedBox(
            width: 360.0,
            height: 180.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 360.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    gradient:const LinearGradient(
                      begin: Alignment(1.498, -0.675),
                      end: Alignment(-0.974, 0.973),
                      colors: [
                         Color(0xffd4d4d4),
                         Color(0xff00a6be)
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow:const [
                      BoxShadow(
                        color:  Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 360.0,
                  height: 180.0,
                  child: Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(39.0, -106.1),
                        child: SizedBox(
                          width: 311.0,
                          height: 284.0,
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 311.0,
                                height: 284.0,
                                child: SvgPicture.string(
                                  '<svg viewBox="0.0 0.0 311.4 284.2" ><path transform="translate(0.0, 0.0)" d="M 127.8947372436523 0 C 198.529052734375 0 255.7894744873047 57.26043319702148 255.7894744873047 127.8947372436523 C 255.7894744873047 198.529052734375 198.529052734375 255.7894744873047 127.8947372436523 255.7894744873047 C 57.26043319702148 255.7894744873047 0 198.529052734375 0 127.8947372436523 C 0 57.26043319702148 57.26043319702148 0 127.8947372436523 0 Z" fill="#ffffff" fill-opacity="0.04" stroke="none" stroke-width="1" stroke-opacity="0.04" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(73.0, 60.63)" d="M 111.7894744873047 0 C 173.5290832519531 0 223.5789489746094 50.04985809326172 223.5789489746094 111.7894744873047 C 223.5789489746094 173.5290832519531 173.5290832519531 223.5789489746094 111.7894744873047 223.5789489746094 C 50.04985809326172 223.5789489746094 0 173.5290832519531 0 111.7894744873047 C 0 50.04985809326172 50.04985809326172 0 111.7894744873047 0 Z" fill="#ffffff" fill-opacity="0.05" stroke="none" stroke-width="1" stroke-opacity="0.05" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(139.0, 60.63)" d="M 86.21052551269531 0 C 133.8232879638672 0 172.4210510253906 38.59777069091797 172.4210510253906 86.21052551269531 C 172.4210510253906 133.8232879638672 133.8232879638672 172.4210510253906 86.21052551269531 172.4210510253906 C 38.59777069091797 172.4210510253906 0 133.8232879638672 0 86.21052551269531 C 0 38.59777069091797 38.59777069091797 0 86.21052551269531 0 Z" fill="#ffffff" fill-opacity="0.08" stroke="none" stroke-width="1" stroke-opacity="0.08" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                  allowDrawingOutsideViewBox: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 360.0,
                        height: 180.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset:const Offset(15.0, 155.0),
            child:const Text(
              'BEP-20',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 10,
                color: Color(0x89ffffff),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            ),
          ),
          Transform.translate(
            offset:const Offset(20.0, 86.0),
            child: SizedBox(
              width: 320.0,
              height: 64.0,
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset:const Offset(0.0, 45.0),
                    child: const SizedBox(
                      width: 320.0,
                      height: 19.0,
                      child: Text(
                        '≈ 1,200 PHP',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Color(0x99ffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 320.0,
                    height: 42.0,
                    child: Text(
                      '${widget.rsg} RSG',
                      style:const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 34,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 360.0,
            height: 73.0,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: 360.0,
                  height: 63.0,
                  child: SvgPicture.string(
                    '<svg viewBox="15.0 137.0 360.0 63.0" ><path transform="translate(5965.0, 112.0)" d="M -5741.70947265625 88.00039672851562 C -5741.3212890625 87.3568115234375 -5740.94775390625 86.68484497070312 -5740.59716796875 86.00093078613281 L -5589.99951171875 86.00093078613281 L -5589.99951171875 87.99890899658203 L -5589.99951171875 88.00039672851562 L -5741.70947265625 88.00039672851562 Z M -5798.29052734375 88.00039672851562 L -5798.2890625 88.00039672851562 Z M -5798.2890625 88.00039672851562 Z M -5950.00048828125 88.00039672851562 L -5950.00048828125 86.00093078613281 L -5799.4013671875 86.00093078613281 C -5799.05517578125 86.67588806152344 -5798.681640625 87.34934234619141 -5798.29052734375 87.99890899658203 L -5798.2890625 88.00039672851562 L -5950.00048828125 88.00039672851562 Z M -5738.541015625 81.00003051757812 C -5738.33642578125 80.35195922851562 -5738.14501953125 79.67999267578125 -5737.9765625 79.00056457519531 L -5589.99951171875 79.00056457519531 L -5589.99951171875 80.99853515625 L -5589.99951171875 81.00003051757812 L -5738.541015625 81.00003051757812 Z M -5801.458984375 81.00003051757812 L -5801.45751953125 81.00003051757812 Z M -5801.45751953125 81.00003051757812 L -5950.00048828125 81.00003051757812 L -5950.00048828125 79.00056457519531 L -5802.0234375 79.00056457519531 C -5801.85791015625 79.66506195068359 -5801.66796875 80.33702087402344 -5801.45751953125 80.99853515625 L -5801.45751953125 81.00003051757812 Z M -5802.76123046875 75.00163269042969 L -5950.00048828125 75.00013732910156 L -5950.00048828125 39.99977493286133 C -5950.00048828125 35.99337768554688 -5948.43994140625 32.22589874267578 -5945.60595703125 29.39319610595703 C -5942.77294921875 26.56049537658691 -5939.005859375 25.00004577636719 -5935.00048828125 25.00004577636719 L -5605.00048828125 25.00004577636719 C -5600.994140625 25.00004577636719 -5597.22705078125 26.56049537658691 -5594.392578125 29.39319610595703 C -5591.56005859375 32.22589874267578 -5589.99951171875 35.99337768554688 -5589.99951171875 39.99977493286133 L -5589.99951171875 75.00013732910156 L -5737.23876953125 75.00013732910156 C -5737.08056640625 73.68607330322266 -5737 72.33915710449219 -5737 70.99971008300781 C -5737 66.54533386230469 -5737.8720703125 62.22386169433594 -5739.59228515625 58.15474700927734 C -5741.25537109375 54.22450637817383 -5743.63427734375 50.69594955444336 -5746.6640625 47.6661376953125 C -5749.6953125 44.63483428955078 -5753.22412109375 42.25608062744141 -5757.154296875 40.59408950805664 C -5761.22314453125 38.87236785888672 -5765.544921875 38.00030899047852 -5770.00048828125 38.00030899047852 C -5774.455078125 38.00030899047852 -5778.7763671875 38.87236785888672 -5782.845703125 40.59408950805664 C -5786.7744140625 42.25458526611328 -5790.30322265625 44.63483428955078 -5793.33447265625 47.6661376953125 C -5796.3642578125 50.69594955444336 -5798.744140625 54.22450637817383 -5800.40625 58.15474700927734 C -5802.12646484375 62.22386169433594 -5803 66.54533386230469 -5803 70.99971008300781 C -5803 72.33617401123047 -5802.91943359375 73.68309020996094 -5802.759765625 75.00013732910156 L -5802.759765625 75.00163269042969 Z" fill="#ffffff" fill-opacity="0.25" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Transform.translate(
                  offset: Offset(155.0, 25.0),
                  child: Container(
                    width: 50.0,
                    height: 48.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:  AssetImage('imgs/logo@2x.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(224.0, 15.0),
                  child: SizedBox(
                    width: 121.0,
                    height: 18.0,
                    child: Stack(
                      children: <Widget>[
                        Transform.translate(
                          offset: Offset(103.0, 0.0),
                          child: SizedBox(
                            width: 18.0,
                            height: 18.0,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 18.0,
                                  height: 18.0,
                                  color: const Color(0x00ffffff),
                                ),
                                Transform.translate(
                                  offset: Offset(2.0, 2.0),
                                  child: SizedBox(
                                    width: 14.0,
                                    height: 14.0,
                                    child: SvgPicture.string(
                                      '<svg viewBox="341.0 155.0 14.0 14.0" ><path transform="translate(6627.5, 281.5)" d="M -6284.4169921875 -112.5019073486328 C -6285.56591796875 -112.5019073486328 -6286.50048828125 -113.4352416992188 -6286.50048828125 -114.5837249755859 L -6286.50048828125 -122.3110809326172 C -6286.50048828125 -123.4595642089844 -6285.56591796875 -124.3928833007812 -6284.4169921875 -124.3928833007812 L -6280.20361328125 -124.3928833007812 C -6279.8291015625 -124.3928833007812 -6279.52587890625 -124.0893859863281 -6279.52587890625 -123.7160491943359 C -6279.52587890625 -123.34130859375 -6279.8291015625 -123.0392150878906 -6280.20361328125 -123.0392150878906 L -6284.4169921875 -123.0392150878906 C -6284.8193359375 -123.0392150878906 -6285.1455078125 -122.7114868164062 -6285.1455078125 -122.3110809326172 L -6285.1455078125 -114.5837249755859 C -6285.1455078125 -114.1833343505859 -6284.8193359375 -113.8570251464844 -6284.4169921875 -113.8570251464844 L -6276.69140625 -113.8570251464844 C -6276.28955078125 -113.8570251464844 -6275.96337890625 -114.1833343505859 -6275.96337890625 -114.5837249755859 L -6275.96337890625 -118.7986450195312 C -6275.96337890625 -119.1734008789062 -6275.65966796875 -119.4754791259766 -6275.2861328125 -119.4754791259766 C -6274.91162109375 -119.4754791259766 -6274.609375 -119.1734008789062 -6274.609375 -118.7986450195312 L -6274.609375 -114.5837249755859 C -6274.609375 -113.4352416992188 -6275.54296875 -112.5019073486328 -6276.69140625 -112.5019073486328 L -6284.4169921875 -112.5019073486328 Z M -6281.38525390625 -117.6173858642578 C -6281.650390625 -117.8824157714844 -6281.650390625 -118.3113250732422 -6281.38525390625 -118.5749359130859 L -6274.81494140625 -125.1452484130859 L -6277.3935546875 -125.1452484130859 C -6277.76708984375 -125.1452484130859 -6278.0703125 -125.4487457275391 -6278.0703125 -125.8235168457031 C -6278.0703125 -126.1968383789062 -6277.76708984375 -126.5003356933594 -6277.3935546875 -126.5003356933594 L -6273.208984375 -126.5003356933594 C -6273.05126953125 -126.5074462890625 -6272.8916015625 -126.4596252441406 -6272.76171875 -126.3568572998047 C -6272.7587890625 -126.3546600341797 -6272.75537109375 -126.3524169921875 -6272.7529296875 -126.3501892089844 C -6272.751953125 -126.3496551513672 -6272.751953125 -126.3491668701172 -6272.7509765625 -126.3486328125 C -6272.59814453125 -126.2244567871094 -6272.50048828125 -126.0352172851562 -6272.50048828125 -125.8235168457031 L -6272.50048828125 -121.6085968017578 C -6272.50048828125 -121.2338409423828 -6272.80419921875 -120.9317474365234 -6273.1787109375 -120.9317474365234 C -6273.55224609375 -120.9317474365234 -6273.85595703125 -121.2338409423828 -6273.85595703125 -121.6085968017578 L -6273.85595703125 -124.1891326904297 L -6280.42724609375 -117.6173858642578 C -6280.55810546875 -117.4848785400391 -6280.732421875 -117.4193267822266 -6280.90625 -117.4193267822266 C -6281.07861328125 -117.4193267822266 -6281.25244140625 -117.4848785400391 -6281.38525390625 -117.6173858642578 Z" fill="#ffffff" stroke="none" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 98.0,
                          height: 18.0,
                          child: Stack(
                            children: <Widget>[
                              Transform.translate(
                                offset: Offset(80.0, 0.0),
                                child: Container(
                                  width: 18.0,
                                  height: 18.0,
                                  color: const Color(0x00ffffff),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(82.7, 1.8),
                                child: SizedBox(
                                  width: 12.0,
                                  height: 14.0,
                                  child: SvgPicture.string(
                                    '<svg viewBox="331.7 154.8 12.4 14.4" ><path transform="translate(328.7, 153.3)" d="M 12.1636381149292 1.500000238418579 L 4.309090614318848 1.500000238418579 C 3.589091300964355 1.500000238418579 3 2.089091062545776 3 2.809091329574585 L 3 11.97272777557373 L 4.309090614318848 11.97272777557373 L 4.309090614318848 2.809091329574585 L 12.1636381149292 2.809091329574585 L 12.1636381149292 1.500000238418579 Z M 14.12727355957031 4.118181705474854 L 6.927273273468018 4.118181705474854 C 6.207273006439209 4.118181705474854 5.618182182312012 4.707273006439209 5.618182182312012 5.427272319793701 L 5.618182182312012 14.59090995788574 C 5.618182182312012 15.31091022491455 6.207273006439209 15.90000057220459 6.927273273468018 15.90000057220459 L 14.12727355957031 15.90000057220459 C 14.8472728729248 15.90000057220459 15.43636322021484 15.31091022491455 15.43636322021484 14.59090995788574 L 15.43636322021484 5.427272319793701 C 15.43636322021484 4.707273006439209 14.8472728729248 4.118181705474854 14.12727355957031 4.118181705474854 Z M 14.12727355957031 14.59090995788574 L 6.927273273468018 14.59090995788574 L 6.927273273468018 5.427272319793701 L 14.12727355957031 5.427272319793701 L 14.12727355957031 14.59090995788574 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0.0, 2.0),
                                child:  SizedBox(
                                  width: 80.0,
                                  height: 15.0,
                                  child: Text(
                                    AppSingleton.userInfoModel?.rpWalletAddress??'0xdf5…c405',
                                    style:const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(20.0, 12.0),
                  child: SizedBox(
                    width: 104.0,
                    height: 29.0,
                    child: Stack(
                      children: <Widget>[
                       const SizedBox(
                          width: 104.0,
                          height: 16.0,
                          child: Text(
                            'RSG Wallet',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0.0, 16.0),
                          child:const  SizedBox(
                            width: 77.0,
                            height: 13.0,
                            child: Text(
                              'Resiklos Gems',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 10,
                                color: Color(0x89ffffff),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
