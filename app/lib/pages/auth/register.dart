import 'package:app/provider/register_provider.dart';
import 'package:app/utils/auth_result.dart';
import 'package:app/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final Function changePage;

  RegisterPage(this.changePage);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider<RegisterProvider>(
        create: (_) => RegisterProvider(),
        builder: (context, child) {
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
                      top: 15,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to the app, before your enter the home screen please Sign Up.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorsPalete.text),
                      )
                    ],
                  ),
                ),
                Consumer<RegisterProvider>(
                    builder: (context, registerProvider, child) {
                  return Container(
                    height: 55,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 35,
                        left: size.width * 0.05,
                        right: size.width * 0.05),
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
                      controller: registerProvider.nameController,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (e) => registerProvider.validateName(),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Name'),
                    ),
                  );
                }),
                Consumer<RegisterProvider>(
                    builder: (context, registerProvider, child) {
                  if (registerProvider.submited &&
                      registerProvider.nameCorrect?.message != null)
                    return Container(
                      margin: EdgeInsets.only(
                          top: 5,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Text(
                        registerProvider.nameCorrect!.message!,
                        style: TextStyle(fontSize: 11, color: Colors.red),
                      ),
                    );
                  return SizedBox();
                }),
                Consumer<RegisterProvider>(
                    builder: (context, registerProvider, child) {
                  return Container(
                    height: 55,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 12,
                        left: size.width * 0.05,
                        right: size.width * 0.05),
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
                      controller: registerProvider.emailController,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (e) => registerProvider.validateEmail(),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Email'),
                    ),
                  );
                }),
                Consumer<RegisterProvider>(
                    builder: (context, registerProvider, child) {
                  if (registerProvider.submited &&
                      registerProvider.emailCorrect?.message != null)
                    return Container(
                      margin: EdgeInsets.only(
                          top: 5,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Text(
                        registerProvider.emailCorrect!.message!,
                        style: TextStyle(fontSize: 11, color: Colors.red),
                      ),
                    );
                  return SizedBox();
                }),
                Consumer<RegisterProvider>(
                    builder: (context, registerProvider, child) {
                  return Container(
                    height: 55,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 12,
                        left: size.width * 0.05,
                        right: size.width * 0.05),
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
                      obscureText: !registerProvider.showPassword,
                      controller: registerProvider.passwordController,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (e) => registerProvider.validatePassword(),
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => registerProvider.changePasswordShow(),
                            child: Icon(
                              Icons.remove_red_eye_outlined,
                              color: registerProvider.showPassword
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
                Consumer<RegisterProvider>(
                    builder: (context, registerProvider, child) {
                  if (registerProvider.submited &&
                      registerProvider.passwordCorrect?.message != null)
                    return Container(
                      margin: EdgeInsets.only(
                          top: 5,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Text(
                        registerProvider.passwordCorrect!.message!,
                        style: TextStyle(fontSize: 11, color: Colors.red),
                      ),
                    );
                  return SizedBox();
                }),
                Container(
                  height: 55,
                  margin: EdgeInsets.only(
                      top: 30,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
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
                  child: Consumer<RegisterProvider>(
                      builder: (context, registerProvider, child) {
                    return TextButton(
                      onPressed: () async {
                        AuthResult response = await registerProvider.register();
                        print(response.success);
                        print(response.message);
                        if (response.success) {
                          changePage(0);
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 10,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
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
                                text: 'Sign In',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => changePage(0))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
          );
        });
  }
}
