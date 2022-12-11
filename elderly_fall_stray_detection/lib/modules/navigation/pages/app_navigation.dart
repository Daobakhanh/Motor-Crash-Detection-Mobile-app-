import 'package:elderly_fall_stray_detection/modules/personal/page/personal_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';
import '../../home/page/home_page.dart';
import '../../motobike_remote_feature/page/motobike_remote_feature_page.dart';
import '../../notification/page/notification_page.dart';

class AppNavigationConfig extends StatefulWidget {
  const AppNavigationConfig({Key? key}) : super(key: key);

  @override
  State<AppNavigationConfig> createState() => _AppNavigationConfigState();
}

class _AppNavigationConfigState extends State<AppNavigationConfig> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).brightness;
    return CupertinoTabScaffold(
      // backgroundColor: AppColor.greyBold,
      tabBar: CupertinoTabBar(
        activeColor: AppColor.pinkAccent,
        inactiveColor:
            themeData == Brightness.dark ? AppColor.grey : AppColor.dark,
        backgroundColor:
            themeData == Brightness.dark ? AppColor.dark : AppColor.lightGray,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              // onGenerateRoute: ,
              // routes: {
              //   '/postDetail': (context) => const PostDetailPage(),
              // },

              builder: (context) {
                return const CupertinoPageScaffold(
                  child: HomePage(),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: MotobikeRemoteFeaturePage(),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: NotificationPage(),
                );
              },
            );
          case 3:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: PersonalPage(),
                );
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: HomePage(),
                );
              },
            );
        }
      },
    );
  }
}
