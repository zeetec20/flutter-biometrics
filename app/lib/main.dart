import 'package:app/pages/wrapper_app.dart';
import 'package:app/provider/app_provider.dart';
import 'package:app/provider/login_provider.dart';
import 'package:app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(UserRepository())),
        ChangeNotifierProvider(create: (_) => LoginProvider(UserRepository()))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WrapperApp(),
      ),
    );
  }
}
