import 'package:app/pages/auth/login.dart';
import 'package:app/pages/auth/register.dart';
import 'package:flutter/material.dart';

class WrapperAuth extends StatelessWidget {
  final PageController pageController = PageController();

  changePage(int page) async => await pageController.animateToPage(page,
      duration: Duration(milliseconds: 350), curve: Curves.easeIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LoginPage((page) => changePage(page)),
          RegisterPage((page) => changePage(page)),
        ],
      ),
    );
  }
}
