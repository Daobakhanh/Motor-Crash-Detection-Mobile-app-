import 'package:motorbike_crash_detection/themes/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../common/term/app_term.dart';

class MotobikeRemoteFeaturePage extends StatefulWidget {
  const MotobikeRemoteFeaturePage({super.key});

  @override
  State<MotobikeRemoteFeaturePage> createState() =>
      _MotobikeRemoteFeaturePageState();
}

class _MotobikeRemoteFeaturePageState extends State<MotobikeRemoteFeaturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppRouteName.feature),
      ),
      body: const Center(
          child: Text(
        AppTerm.featureComingSoon,
        style: AppTextStyle.h1,
      )),
    );
  }
}
