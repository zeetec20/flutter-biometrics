import 'package:app/provider/app_provider.dart';
import 'package:app/service/user_service.dart';
import 'package:app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool isDialogOpen = false;

class BiometricsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    provider.authBiometrics('test biometrics').then((result) {
      print(result.success);
      print(result.message);
      if (!result.success && !isDialogOpen) {
        isDialogOpen = true;
        showDialog(
          context: context,
          builder: (context) {
            return ChangeNotifierProvider.value(
              value: provider,
              builder: (context, child) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Text(
                            'Biometrics',
                            style: TextStyle(
                                fontSize: 25,
                                color: ColorsPalete.text,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            result.message!,
                            style: TextStyle(
                                color: ColorsPalete.text, fontSize: 12),
                          ),
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: ColorsPalete.backgroundCom,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(
                              top: 35,
                              bottom: 25,
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: TextButton(
                            onPressed: () {
                              Provider.of<AppProvider>(context, listen: false)
                                  .refresh();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Try Again',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ).then((value) => isDialogOpen = false);
      }
    });

    return Scaffold(
      backgroundColor: ColorsPalete.background,
      body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: constraints.maxHeight * 0.95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.fingerprint_rounded,
                          size: 75,
                          color: ColorsPalete.text,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'Touch the fingerprint sensor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: ColorsPalete.text,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: size.height * 0.1),
                        child: Icon(
                          Icons.lock_rounded,
                          size: 35,
                          color: ColorsPalete.backgroundCom,
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        'App Locked',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: ColorsPalete.text),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      })),
    );
  }
}
