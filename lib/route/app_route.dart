import 'package:flutter/material.dart';

import '../lib.dart';

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
  static const String personalLinkToDevice = '/personal-link-to-device';
  static const String personalDrawer = '/personal-drawer';
  static const String setRootGy = '/set-root-gy';

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
          // builder: (_) => const NotificationPage(),
          builder: (_) => const NotificationStreamPage(),
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
      case personalLinkToDevice:
        return MaterialPageRoute(
          builder: (_) => const PersonalLinkToDevice(),
        );
      case setRootGy:
        return MaterialPageRoute(
          builder: (_) => const VehicleSetRootGYPage(),
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
