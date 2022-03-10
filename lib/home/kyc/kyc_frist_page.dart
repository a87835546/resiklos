import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:resiklos/base_class/base_page.dart';
import 'package:resiklos/home/kyc/kyc_progress_widget.dart';
import 'package:resiklos/home/setting/setting_request.dart';
import 'package:resiklos/rk_app_bar.dart';
import 'package:resiklos/utils/color.dart';
import 'package:country_picker/src/utils.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:resiklos/utils/toast.dart';

class KycFirstPage extends BaseStatefulWidget {
  const KycFirstPage({Key? key}) : super(key: key);

  @override
  BaseStatefulState<BaseStatefulWidget> getState() => _KycFirstPageState();
}

class _KycFirstPageState extends BaseStatefulState<KycFirstPage> {
  final List<PersonalModel> _list = [
    PersonalModel("Country of Origin", PersonalType.country, null),
    PersonalModel("First Name", PersonalType.firstname, null),
    PersonalModel("Last Name", PersonalType.lastname, null),
    PersonalModel("Date of Birth", PersonalType.birthday, null),
    PersonalModel("Gender", PersonalType.gender, null),
    PersonalModel("Mobile Number", PersonalType.mobile, null),
  ];
  String _country = "Philippines";
  String _countryCode = "PH";
  bool _isMale = true;
  String? firstname;
  String? lastname;
  String? mobile;
  String? birthday;
  var _date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "PERSONAL VERIFICATION",
      ),
      body: Stack(
        children: [
          KYCProgressWidget(
            type: 1,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Personal Information',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 20,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
                Container(
                  child: _widget(),
                ),
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        color: mainColor(),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      width: 232,
                      height: 50,
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    if (_country == null) {
                      showErrorText("please select country ");
                      return;
                    } else if (firstname == null) {
                      showErrorText("please input first name ");
                      return;
                    } else if (lastname == null) {
                      showErrorText("please input last name ");
                      return;
                    } else if (_date == null) {
                      showErrorText("please select birthday ");
                      return;
                    } else if (mobile == null) {
                      showErrorText("please input mobile ");
                      return;
                    }
                    var result = await uploadUserInfo(_date.toString(),
                        _country, firstname, _isMale, lastname, mobile);
                    if (result == true) {}
                    log("start verify kyc ----->>>>> country:$_country  firstname:$firstname lastname:$lastname birthday:$_date gender:$_isMale mobile:$mobile");
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _widget() {
    return Container(
      child: Column(children: [
        Column(
          children: _list.map((PersonalModel e) {
            if (e.type == PersonalType.gender) {
              return Container(
                  child: Column(children: [
                Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 10, bottom: 5),
                    child: const Text(
                      'Gender',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1),
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )),
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 10),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _isMale ? _selectedIcon() : _icon(),
                              SizedBox(width: 10),
                              const Text(
                                'Male',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          log("click male");
                          setState(() {
                            _isMale = true;
                          });
                        },
                        behavior: HitTestBehavior.translucent,
                      ),
                      SizedBox(width: 39),
                      GestureDetector(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _isMale ? _icon() : _selectedIcon(),
                              SizedBox(width: 10),
                              const Text(
                                'Female',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          log("click female");
                          setState(() {
                            _isMale = false;
                          });
                        },
                        behavior: HitTestBehavior.translucent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ]));
            } else if (e.type == PersonalType.country) {
              return _selectCountry(e);
            } else if (e.type == PersonalType.birthday) {
              return _selectBirthday(e);
            } else {
              return _inputWidget(e);
            }
          }).toList(),
        ),
      ]),
    );
  }

  Widget _icon() {
    return // Figma Flutter Generator Group198Widget - GROUP
        Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              border: Border.all(
                color: Color.fromRGBO(191, 191, 191, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.elliptical(16, 16)),
            ));
  }

  Widget _selectedIcon() {
    return // Figma Flutter Generator Group198Widget - GROUP
        Container(
            width: 16,
            height: 16,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(0, 166, 190, 1),
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.elliptical(16, 16)),
                      ))),
              Positioned(
                  top: 3,
                  left: 3,
                  child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 166, 190, 1),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10)),
                      ))),
            ]));
  }

  Widget _selectCountry(PersonalModel e) {
    return Container(
        child: Column(children: [
      Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: Text(
            e.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          )),
      GestureDetector(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffBFBFBF), width: 1),
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                child: Text(
                  Utils.countryCodeToEmoji(_countryCode),
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(_country,
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xff707070))))
            ],
          ),
        ),
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: true,
            // optional. Shows phone code before the country name.
            onSelect: (Country country) {
              log('Select country: $country}  ${Utils.countryCodeToEmoji(country.countryCode)}');
              setState(() {
                _countryCode = country.countryCode;
                _country = country.name;
              });
            },
          );
        },
      ),
      SizedBox(
        height: 20,
      )
    ]));
  }

  Widget _selectBirthday(PersonalModel e) {
    return Container(
        child: Column(children: [
      Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: Text(
            e.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          )),
      GestureDetector(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffBFBFBF), width: 1),
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                child: Text(
                  birthday ?? "--/--/----",
                  style: TextStyle(
                      color: birthday != null
                          ? Color(0xff707070)
                          : Color(0xffD4D4D4),
                      fontSize: 10),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.date_range,
                  size: 16,
                  color: Color(0xff707070),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1900, 01, 01),
              maxTime: DateTime.now(),
              theme: DatePickerTheme(
                  headerColor: mainColor(),
                  backgroundColor: Colors.white,
                  itemStyle: TextStyle(
                      color: mainTitleColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
              onConfirm: (date) {
            e.value = "${date.year}/${date.month}/${date.day}";
            setState(() {
              birthday = "${date.month}/${date.day}/${date.year}";
              _date = date;
            });
            print('confirm ${date.year}/${date.month}/${date.day}');
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
      ),
      SizedBox(
        height: 20,
      )
    ]));
  }

  Widget _inputWidget(PersonalModel e) {
    return Container(
        child: Column(children: [
      Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: Text(
            e.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Color.fromRGBO(112, 112, 112, 1),
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          )),
      Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffBFBFBF), width: 1),
            borderRadius: BorderRadius.circular(25)),
        child: TextField(
          keyboardType:
              e.type == PersonalType.mobile ? TextInputType.number : null,
          decoration: InputDecoration(
              hintText: "Entry your ${e.title.toLowerCase()}",
              hintStyle: TextStyle(color: Color(0xffD4D4D4), fontSize: 10),
              contentPadding: EdgeInsets.only(left: 15),
              border: InputBorder.none),
          onChanged: (v) {
            setState(() {
              e.value = v;
              switch (e.type) {
                case PersonalType.firstname:
                  {
                    firstname = v;
                    break;
                  }
                case PersonalType.lastname:
                  {
                    lastname = v;
                    break;
                  }
                case PersonalType.birthday:
                  {
                    birthday = v;
                    break;
                  }
                case PersonalType.mobile:
                  {
                    mobile = v;
                    break;
                  }
              }
            });
          },
        ),
      ),
      SizedBox(
        height: 20,
      )
    ]));
  }
}

enum PersonalType { country, firstname, lastname, mobile, birthday, gender }

class PersonalModel {
  String title;
  PersonalType type;
  dynamic value;

  PersonalModel(this.title, this.type, this.value);
}
