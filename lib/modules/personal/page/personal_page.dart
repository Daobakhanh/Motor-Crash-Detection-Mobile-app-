import 'package:flutter/material.dart';

import '../../../common/app_term.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppRouteName.personal),
      ),
      body: const Center(child: Text(AppDataTerm.featureComingSoon)),
    );
  }
}
