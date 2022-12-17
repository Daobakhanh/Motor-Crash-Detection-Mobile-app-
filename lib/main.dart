import 'package:elderly_fall_stray_detection/modules/navigation/pages/app_navigation.dart';
import 'package:elderly_fall_stray_detection/themes/app_font.dart';
import 'package:elderly_fall_stray_detection/themes/app_text_style.dart';
import 'package:flutter/material.dart';

import 'modules/auth/page/auth_page.dart';
import 'themes/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: AppFont.avenir,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            color: AppColor.greyBold,
            centerTitle: true,
          ),
        ),
        home: const AuthPage());
  }
}
