import 'package:badges/badges.dart';
import 'package:motorbike_crash_detection/modules/notification/bloc/notification_stream_bloc.dart';
import 'package:motorbike_crash_detection/modules/notification/model/notification_model.dart';
import 'package:motorbike_crash_detection/modules/notification/page/notification_stream_page.dart';
import 'package:motorbike_crash_detection/modules/personal/page/personal_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';
import '../../home/page/home_page.dart';
import '../../motobike_remote_feature/page/motobike_remote_feature_page.dart';
import '../../notification/page/notification_page.dart';
import '../../providers/bloc_provider.dart';

class AppNavigationConfig extends StatefulWidget {
  final bool? navigateKeyPersonal;
  const AppNavigationConfig({this.navigateKeyPersonal, Key? key})
      : super(key: key);

  @override
  State<AppNavigationConfig> createState() => _AppNavigationConfigState();
}

class _AppNavigationConfigState extends State<AppNavigationConfig> {
  late final NotificationBlocStream _notficationBlocStreamController;

  // NotificationBlocStream get _notificationBlocStream =>
  //     BlocProvider.of<NotificationBlocStream>(context)!;

  @override
  void initState() {
    super.initState();
    _notficationBlocStreamController = NotificationBlocStream();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).brightness;
    return BlocProvider(
      bloc: _notficationBlocStreamController,
      child: StreamBuilder<NotificationBlocStreamState>(
        stream: _notficationBlocStreamController.notiStream,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final List<NotificationModel> numberOfNoti =
                snapshot.data!.notifications!;
            int numberOfNotiUnRead = 0;
            for (var element in numberOfNoti) {
              if (element.isRead == false) {
                numberOfNotiUnRead++;
              }
            }
            return CupertinoTabScaffold(
              // backgroundColor: AppColor.greyBold,
              tabBar: CupertinoTabBar(
                currentIndex: 1,
                activeColor: AppColor.pinkAccent,
                inactiveColor: themeData == Brightness.dark
                    ? AppColor.grey
                    : AppColor.dark,
                backgroundColor: themeData == Brightness.dark
                    ? AppColor.dark
                    : AppColor.lightGray1,
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.motorcycle,
                      size: 40,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: numberOfNotiUnRead != 0
                        ? Badge(
                            badgeContent: Text(
                              numberOfNotiUnRead.toString(),
                              style: const TextStyle(color: AppTextColor.light),
                            ),
                            child: const Icon(Icons.notifications),
                          )
                        : const Icon(Icons.notifications),
                  ),
                ],
              ),
              tabBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return CupertinoTabView(
                      builder: (context) {
                        return const CupertinoPageScaffold(
                          child: PersonalPage(),
                        );
                      },
                    );

                  case 1:
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

                  case 2:
                    return CupertinoTabView(
                      builder: (context) {
                        return const CupertinoPageScaffold(
                          // child: NotificationPage(),
                          child: NotificationStreamPage(),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Future<int> numberUnReadNoti(List<NotificationModel> list) async {
    int numberUnReadNoti = 0;
    for (var element in list) {
      if (element.isRead == false) {
        numberUnReadNoti++;
      }
    }
    return numberUnReadNoti;
  }
}
