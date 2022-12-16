import 'package:elderly_fall_stray_detection/themes/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../common/app_term.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppRouteName.homepage),
      ),
      body: const Center(
          child: Text(
        AppDataTerm.featureComingSoon,
        style: AppTextStyle.h1,
      )),
    );
  }
}
