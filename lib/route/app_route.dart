import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/main.dart';
import 'package:motorbike_crash_detection/modules/auth/page/auth_page.dart';
import 'package:motorbike_crash_detection/modules/auth/page/auth_signin_page.dart';
import 'package:motorbike_crash_detection/modules/auth/page/auth_signup_page.dart';
import 'package:motorbike_crash_detection/modules/home/page/home_page.dart';
import 'package:motorbike_crash_detection/modules/navigation/pages/app_navigation.dart';
import 'package:motorbike_crash_detection/modules/notification/page/notification_page.dart';
import 'package:motorbike_crash_detection/modules/personal/page/personal_edit_page.dart';
import 'package:motorbike_crash_detection/modules/personal/page/personal_page.dart';

class AppRoute {
  static const String myApp = '/';
  static const String appNavigatorConfig = '/appNavigatorConfig';
  static const String home = '/home';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String auth = '/auth';
  static const String notification = '/notification';
  static const String personal = '/personal';
  static const String personalUpdateInfor = '/personal-update-information';
  static const String personalDrawer = '/personal-drawer';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case myApp:
        return MaterialPageRoute(
          builder: (_) => const MyApp(),
        );
      case appNavigatorConfig:
        return MaterialPageRoute(
          builder: (_) => const AppNavigationConfig(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case signin:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SigninPage(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignupPage(),
        );
      case auth:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AuthPage(),
        );
      case notification:
        return MaterialPageRoute(
          builder: (_) => const NotificationPage(),
        );
      case personal:
        return MaterialPageRoute(
          builder: (_) => const PersonalPage(),
        );
      case personalUpdateInfor:
        return MaterialPageRoute(
          builder: (_) => const PersonalEditInforPage(
            deviceId: '',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
