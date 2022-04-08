import 'package:app/provider/app_provider.dart';
import 'package:app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsPalete.background,
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.2),
            alignment: Alignment.center,
            child: Text(
              'Wellcome to the app',
              style: TextStyle(
                  color: ColorsPalete.text,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
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
            child:
                Consumer<AppProvider>(builder: (context, appProvider, child) {
              return TextButton(
                onPressed: () async {
                  appProvider.settingBiometrics();
                },
                child: Text(
                  '${appProvider.user!.useBiometrics ? 'Deactive' : 'Active'} Biometrics',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              );
            }),
          ),
          Container(
            height: 55,
            margin: EdgeInsets.only(
                top: 20, left: size.width * 0.05, right: size.width * 0.05),
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
            child:
                Consumer<AppProvider>(builder: (context, appProvider, child) {
              return TextButton(
                onPressed: () async {
                  await appProvider.setUser(null);
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              );
            }),
          )
        ],
      )),
    );
  }
}
