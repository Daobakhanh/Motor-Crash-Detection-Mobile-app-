import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../common/app_term.dart';

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
        title: const Text(AppRouteName.feature),
      ),
      body: const Center(child: Text(AppDataTerm.featureComingSoon)),
    );
  }
}
