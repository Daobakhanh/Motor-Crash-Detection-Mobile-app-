import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:motorbike_crash_detection/common/term/app_term.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/modules/app_state/service/app_get_fcm_token_local_storage.dart';
import 'package:unicons/unicons.dart';

import '../../../themes/app_color.dart';
import '../../../themes/app_text_style.dart';
import '../../widget/widget/stateless_widget/button_stl_widget.dart';
import '../utils/auth_show_diolog_utils.dart';
import '../widget/auth_widget.dart';
import 'auth_signin_page.dart';
import 'auth_signup_page.dart';

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
                  // print('press log in');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SigninPage()),
                  );
                },
              ),
            ),
            LongStadiumButton(
              color: AppColor.pinkAccent,
              nameOfButton: 'Sign Up',
              onTap: () async {
                // ignore: avoid_print
                print('Press sign up');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const SignupPage()),
                  ),
                );
                final String? fcmToken = await getFcmToken();
                // ignore: avoid_print
                print('fcmToken: $fcmToken');
              },
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              'Or sign in with',
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
                  // onTap: () async {
                  //   bool loginStatus =
                  //       await LoginWithDofhuntAPI.loginWithDofhuntAPI();

                  //   if (loginStatus) {
                  //     _changeAppState();
                  //   }
                  // },
                  onTap: () {
                    debugPrint('Press google');
                    showMyDialogAuth(context);
                  },
                ),
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

  Future<String?> getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? fcmToken = '';

    //don't save fcm to local storage
    fcmToken = await firebaseMessaging.getToken();
    return fcmToken;
  }
}
