import 'package:elderly_fall_stray_detection/common/app_term.dart';
import 'package:elderly_fall_stray_detection/modules/navigation/pages/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../widget/widget/stateless_widget/button_stl_widget.dart';
import '../utils/auth_show_diolog_utils.dart';
import '../widget/auth_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        // backgroundColor: AppColors.dark,
        title: Text(
          'MoCraDe',
          style: AppTextStyle.appName
              .copyWith(fontStyle: FontStyle.italic, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: 100,
                    width: 100,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                AppTerm.appNameFull,
                style: AppTextStyle.h2.copyWith(fontSize: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                AppTerm.appDescription,
                style:
                    AppTextStyle.body17.copyWith(fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: LongStadiumButton(
                nameOfButton: 'Log In',
                onTap: () {
                  // ignore: avoid_print
                  print('press log in');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const LoginPage()),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AppNavigationConfig()),
                  );
                },
              ),
            ),
            LongStadiumButton(
              color: AppColor.pinkAccent,
              nameOfButton: 'Sign Up',
              onTap: () {
                // ignore: avoid_print
                print('Press sign up');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: ((context) => const SignUpPage()),
                //   ),
                // );
              },
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              'Or log in with',
              style: AppTextStyle.caption13.copyWith(
                color: AppTextColor.grey,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconLoginOptional(
                  icon: UniconsLine.facebook,
                  onTap: () {
                    debugPrint('Press fb');
                    showMyDialogAuth(context);
                  },
                ),
                IconLoginOptional(
                  icon: UniconsLine.twitter,
                  onTap: () {
                    debugPrint('Press twitter');
                    showMyDialogAuth(context);
                  },
                ),
                IconLoginOptional(
                    icon: UniconsLine.google,
                    onTap: () async {
                      // bool loginStatus =
                      //     await LoginWithDofhuntAPI.loginWithDofhuntAPI();

                      // if (loginStatus) {
                      //   _changeAppState();
                      // }
                    }),
              ],
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
