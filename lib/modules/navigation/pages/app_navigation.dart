import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Badge;

import '../../../lib.dart';

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _notficationBlocStreamController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).brightness;
    return BlocProvider(
      bloc: _notficationBlocStreamController,
      child: StreamBuilder<NotificationBlocStreamState>(
        stream: _notficationBlocStreamController.notiStream,
        builder: ((context, snapshot) {
          // if (snapshot.hasData) {
          final List<NotificationModel> numberOfNoti =
              snapshot.data?.notifications ?? <NotificationModel>[];
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
              activeColor: AppColors.pinkAccent,
              inactiveColor: themeData == Brightness.dark
                  ? AppColors.grey
                  : AppColors.dark,
              backgroundColor: themeData == Brightness.dark
                  ? AppColors.dark
                  : AppColors.lightGray1,
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
          // }
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
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
