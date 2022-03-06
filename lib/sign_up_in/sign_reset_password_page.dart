import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resiklos/sign_up_in/sign_button.dart';
import 'package:resiklos/sign_up_in/sign_logo_page.dart';
import 'package:resiklos/sign_up_in/sign_request.dart';
import 'package:resiklos/sign_up_in/sign_up_input_widget.dart';
import 'package:resiklos/utils/navigator_util.dart';
import 'package:resiklos/utils/toast.dart';

class SignResetPasswordPage extends StatefulWidget {
  const SignResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignResetPasswordState();
}

class _SignResetPasswordState extends State<SignResetPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    log("dispose");
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(context),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildPage(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xff00BEBE),
            image: DecorationImage(
                image: AssetImage("imgs/onboarding-bg.png"), fit: BoxFit.fill)),
        height: MediaQuery.of(context).size.height -
            150 +
            MediaQuery.of(context).padding.bottom +
            MediaQuery.of(context).padding.top,
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 140),
              child: Container(
                height: double.maxFinite,
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
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "RESET PASSWORD",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Please login to proceed",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xff707070)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 40,
                          left: (MediaQuery.of(context).size.width - 300) / 2,
                          right: (MediaQuery.of(context).size.width - 300) / 2),
                      child: Container(
                          child: SignUpInputWidget(
                        topLabel: "Email Address",
                        placeholder: 'Enter your email',
                        controller: emailController,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20,
                          left: (MediaQuery.of(context).size.width - 300) / 2,
                          right: (MediaQuery.of(context).size.width - 300) / 2),
                      child: Container(
                          child: SignUpInputWidget(
                        topLabel: "OTP",
                        placeholder: 'Enter your OTP',
                        isOtp: true,
                        getOtp: () async {
                          if (emailController.text.length > 5) {
                            var otp =
                                await SignRequest.getOtp(emailController.text);
                          } else {
                            showErrorText("input correct email address");
                          }
                        },
                        controller: otpController,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20,
                          left: (MediaQuery.of(context).size.width - 300) / 2,
                          right: (MediaQuery.of(context).size.width - 300) / 2),
                      child: Container(
                          width: 300,
                          alignment: Alignment.centerLeft,
                          child: SignUpInputWidget(
                            isPassword: true,
                            topLabel: "Password",
                            placeholder: 'Enter your password',
                            controller: passwordController,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20,
                          left: (MediaQuery.of(context).size.width - 300) / 2,
                          right: (MediaQuery.of(context).size.width - 300) / 2),
                      child: Container(
                          width: 300,
                          alignment: Alignment.centerLeft,
                          child: SignUpInputWidget(
                            isPassword: true,
                            topLabel: "Confirm Password",
                            placeholder: 'Enter your password',
                            controller: confirmPasswordController,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SignButton(
                        disable: true,
                        title: "RESET",
                        click: () async {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            showErrorText("input password was different");
                          } else if (emailController.text.length < 6) {
                            showErrorText("input correct email address");
                          } else {
                            var s = await SignRequest.resetPassword(
                                emailController.text,
                                otpController.text,
                                passwordController.text ==
                                        confirmPasswordController.text
                                    ? passwordController.text
                                    : "");
                            if(s == true){
                              NavigatorUtil.pop(context);
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
            Positioned(
              child: SignLogoPage(),
              left: (MediaQuery.of(context).size.width - 110) / 2,
              top: 70,
            ),
          ],
        ),
      ),
    );
  }
}
