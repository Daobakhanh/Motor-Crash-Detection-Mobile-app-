import 'package:flutter/material.dart';

import '../../../common/term/app_term.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppRouteName.notification),
      ),
      body: const Center(child: Text(AppTerm.featureComingSoon)),
    );
  }
}
