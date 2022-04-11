import 'package:app/model/User.dart';
import 'package:app/pages/auth/wrapper_auth.dart';
import 'package:app/pages/biometrics.dart';
import 'package:app/pages/home.dart';
import 'package:app/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrapperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<SharedPreferences?>(
        create: (_) => SharedPreferences.getInstance(),
        initialData: null,
        builder: (context, child) {
          SharedPreferences? pref = Provider.of<SharedPreferences?>(context);
          if (pref != null) {
            Provider.of<AppProvider>(context, listen: false).setUser(
                pref.containsKey('user.id')
                    ? User(
                        id: pref.getInt('user.id')!,
                        name: pref.getString('user.name')!,
                        email: pref.getString('user.email')!,
                        useBiometrics: pref.getBool('user.useBiometrics')!,
                        token: pref.getString('user.token')!)
                    : null);
            return Scaffold(
              body:
                  Consumer<AppProvider>(builder: (context, appProvider, child) {
                if (appProvider.isAuthenticate) {
                  if (appProvider.user!.useBiometrics &&
                      (!appProvider.isBiometricsAuthenticate))
                    return BiometricsPage();

                  return PageView(
                    controller: appProvider.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [HomePage()],
                  );
                }
                return WrapperAuth();
              }),
            );
          }
          return Container();
        });
  }
}
