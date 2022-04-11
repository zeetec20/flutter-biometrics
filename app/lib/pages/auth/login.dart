import 'package:app/provider/app_provider.dart';
import 'package:app/provider/login_provider.dart';
import 'package:app/utils/auth_result.dart';
import 'package:app/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final Function changePage;

  LoginPage(this.changePage);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorsPalete.background,
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello Guys',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: ColorsPalete.text),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 15, left: size.width * 0.05, right: size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to the app, before your enter the home screen please Sign In.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorsPalete.text),
                )
              ],
            ),
          ),
          Consumer<LoginProvider>(builder: (context, loginProvider, child) {
            return Container(
              height: 55,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 35, left: size.width * 0.05, right: size.width * 0.05),
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(0, 3),
                      blurRadius: 8,
                      spreadRadius: -3,
                    )
                  ]),
              child: TextField(
                key: Key('email-field'),
                onChanged: (e) => loginProvider.validateEmail(),
                controller: loginProvider.emailController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Email'),
              ),
            );
          }),
          Consumer<LoginProvider>(builder: (context, loginProvider, child) {
            if (loginProvider.submited &&
                loginProvider.emailCorrect?.message != null)
              return Container(
                key: Key('email-validate-field'),
                margin: EdgeInsets.only(
                    top: 5, left: size.width * 0.05, right: size.width * 0.05),
                child: Text(
                  loginProvider.emailCorrect!.message!,
                  style: TextStyle(fontSize: 11, color: Colors.red),
                ),
              );
            return SizedBox();
          }),
          Consumer<LoginProvider>(builder: (context, loginProvider, child) {
            return Container(
              height: 55,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 12, left: size.width * 0.05, right: size.width * 0.05),
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(0, 3),
                      blurRadius: 8,
                      spreadRadius: -3,
                    )
                  ]),
              child: TextField(
                key: Key('password-field'),
                obscureText: !loginProvider.showPassword,
                onChanged: (e) => loginProvider.validatePassword(),
                controller: loginProvider.passwordController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () => loginProvider.changePasswordShow(),
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                        color: loginProvider.showPassword
                            ? ColorsPalete.backgroundCom
                            : Colors.grey[500],
                        size: 24,
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: 'Password'),
              ),
            );
          }),
          Consumer<LoginProvider>(builder: (context, loginProvider, child) {
            if (loginProvider.submited &&
                loginProvider.passwordCorrect?.message != null)
              return Container(
                key: Key('password-validate-field'),
                margin: EdgeInsets.only(
                    top: 5, left: size.width * 0.05, right: size.width * 0.05),
                child: Text(
                  loginProvider.passwordCorrect!.message!,
                  style: TextStyle(fontSize: 11, color: Colors.red),
                ),
              );
            return SizedBox();
          }),
          Container(
            height: 55,
            margin: EdgeInsets.only(
                top: 30, left: size.width * 0.05, right: size.width * 0.05),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: ColorsPalete.backgroundCom,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: Offset(0, 3),
                    blurRadius: 10,
                    spreadRadius: -3,
                  )
                ]),
            child: Consumer2<LoginProvider, AppProvider>(
                builder: (context, loginProvider, appProvider, child) {
              return TextButton(
                key: Key('sign-in-button'),
                onPressed: () async {
                  AuthResult response = await loginProvider.login();
                  if (response.success) {
                    await appProvider.setUser(response.user!);
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              );
            }),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 10, left: size.width * 0.05, right: size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Have a account ? ',
                          style: TextStyle(color: ColorsPalete.text)),
                      TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => changePage(1))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
