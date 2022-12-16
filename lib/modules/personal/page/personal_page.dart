import 'package:elderly_fall_stray_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';
import 'package:elderly_fall_stray_detection/themes/app_color.dart';
import 'package:flutter/material.dart';

import '../../../common/app_term.dart';
import 'motorbike_image_detail_page.dart';
import 'personal_drawer_page.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final String imageUrl = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppRouteName.personal),
      ),
      endDrawer: const PersonalDrawerPage(),
      body: ListView(
        children: [
          const SizedBox15H(),
          GestureDetector(
            onTap: (() {
              debugPrint('Press see image detail');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MotorbikeImageDetail(
                    imageUrl: imageUrl,
                  ),
                ),
              );
            }),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              // width: 200,
              height: 100,
            ),
          )
        ],
      ),
    );
  }
}
