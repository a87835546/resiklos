import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resiklos/bottom_navigationbar.dart';
import 'package:resiklos/sign_up_in/sign_button.dart';
import 'package:resiklos/sign_up_in/sign_logo_page.dart';
import 'package:resiklos/sign_up_in/sign_request.dart';
import 'package:resiklos/sign_up_in/sign_up_input_widget.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

/**
 * 登陆
 */
class _SignUpPageState extends State<SignUpPage> {
  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _email;
  String? _imageUrl;

  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  int _loginType = 0;
  List<InputModel> _list = [];
  bool _fullValue = false;

  @override
  void initState() {
    super.initState();
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   if (_currentUser != null) {
    //     SignRequest.handleGetContact(_currentUser!);
    //   }
    // });
    // _googleSignIn.signInSilently();
    // SignRequest.getSdkVersion();
    // SignRequest.updateLoginInfo();
    _list = [
      InputModel("Enter your first name", "First Name", false),
      InputModel("Enter your last name", "Last Name", false),
      InputModel("Enter your email", "Email Address", false),
      InputModel("Enter your password", "Password", true),
      InputModel("Re-enter your password", "Confirm Password", true),
      InputModel("Referral Code", " Referral Code (Optional)", false),
    ];
  }

  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    final isLogin = _token != null && _profile != null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: MediaQuery.removePadding(
        context: context,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imgs/onboarding-bg.png"), fit: BoxFit.fill),
          ),
          constraints: BoxConstraints.expand(),
          child: ListView(
            // shrinkWrap: true,
            children: [
              _buildPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: Container(
            height: MediaQuery.of(context).size.height -
                150 +
                MediaQuery.of(context).padding.bottom +
                MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withAlpha(80),
                      blurRadius: 50.0,
                      offset: Offset(0, -40),
                      spreadRadius: -11)
                ]),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "SIGN UP",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Fill-up the form to register",
                      style: TextStyle(fontSize: 14, color: Color(0xff707070)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: (MediaQuery.of(context).size.width - 300) / 2,
                      right: (MediaQuery.of(context).size.width - 300) / 2),
                  child: Container(
                      child: ListView(
                    shrinkWrap: true,
                    children: _list.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          height: 50,
                          child: SignUpInputWidget(
                            isPassword: e.isPassword,
                            topLabel: e.title,
                            placeholder: e.placeholder,
                            inputValue: (value) {
                              log("${e.placeholder} value $value");
                              e.value = value;
                              if (e.placeholder != "Referral Code") {
                                checkInput();
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, top: 30, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          log("I agree with the Terms and Conditions");
                          setState(() {
                            isAgree = !isAgree;
                            checkInput();
                          });
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              isAgree
                                  ? "imgs/checkbox-checked.png"
                                  : "imgs/checkbox.png",
                              width: 20,
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: "I agree with the ",
                                    style: TextStyle(color: Color(0xff707070))),
                                TextSpan(
                                    text: " Terms and Conditions",
                                    style: TextStyle(color: Color(0xffFF9D00)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ])),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SignButton(
                  disable: _fullValue,
                  title: "SIGN UP",
                  click: () async {
                    if (_fullValue) {
                      String name = _list.first.value! + _list[1].value!;
                      String email = _list[2].value!;
                      String password = _list[3].value!;
                      if (name == null) {
                        showWarnToast("please input the correct name");
                      } else if (email == null) {
                        showWarnToast("please input the correct email");
                      } else if (password == null) {
                        showWarnToast("please input the correct password");
                      } else if (password != _list[4].value) {
                        showWarnToast("password is different");
                      }
                      var model = await SignRequest.registerByName(
                          name, email, password, _list.last.value);
                      if (null != model) {
                        NavigatorUtil.push(
                            context, CustomBottomNavigationBar());
                      }
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Container(
                    alignment: Alignment.center,
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "Already have an account?  ",
                          style: TextStyle(color: Color(0xff707070))),
                      TextSpan(
                          text: " Sign In",
                          style: TextStyle(color: Color(0xffFF9D00)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            }),
                    ])),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: SignLogoPage(),
          left: (MediaQuery.of(context).size.width - 110) / 2,
          top: 30,
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context, FacebookUserProfile profile,
      FacebookAccessToken accessToken, String? email) {
    final avatarUrl = _imageUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (avatarUrl != null)
          Center(
            child: Image.network(avatarUrl),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('User: '),
            Text(
              '${profile.firstName} ${profile.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Text('AccessToken: '),
        Text(
          accessToken.token,
          softWrap: true,
        ),
        if (email != null) Text('Email: $email'),
      ],
    );
  }

  Widget _buildBody() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text("Signed in successfully."),
          Text(_contactText),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            onPressed: () => SignRequest.handleSignOut,
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => SignRequest.handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: () => SignRequest.handleSignIn,
          ),
        ],
      );
    }
  }

  void checkInput() {
    bool tag = isAgree;
    _list.forEach((element) {
      if (element.value == null && element.placeholder != "Referral Code") {
        tag = false;
      }
    });
    if (_list[3].value != _list[4].value) {
      tag = false;
    }
    setState(() {
      _fullValue = tag;
    });
  }
}

class InputModel {
  String placeholder;
  String title;
  String? value;
  bool? isPassword;

  InputModel(this.placeholder, this.title, this.isPassword);
}
