import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';
import '../../navigation/pages/app_navigation.dart';
import '../../widget/widget/stateless_widget/button_stl_widget.dart';

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({super.key});

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  bool isFullFillPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Confirm'),
      ),
      body: LongStadiumButton(
        color: isFullFillPhoneNumber == true
            ? AppColor.pinkAccent
            : AppColor.light,
        nameOfButton: "NEXT",
        onTap: () {
          debugPrint('press login');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppNavigationConfig(),
            ),
          );
        },
      ),
    );
  }
}
