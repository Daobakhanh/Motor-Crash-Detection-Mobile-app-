import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../lib.dart';

class NotificationStreamPage extends StatefulWidget {
  const NotificationStreamPage({super.key});

  @override
  State<NotificationStreamPage> createState() => _NotificationStreamPageState();
}

class _NotificationStreamPageState extends State<NotificationStreamPage> {
  // late final NotificationBlocStream _notficationBlocStreamController;

  NotificationBlocStream get _notificationBlocStream =>
      BlocProvider.of<NotificationBlocStream>(context)!;
  bool isLoadingSeeAll = false;
  @override
  void initState() {
    super.initState();
    // _notficationBlocStreamController = NotificationBlocStream();
    _notificationBlocStream.getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NotificationBlocStreamState>(
      stream: _notificationBlocStream.notiStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.notifications != null) {
          final listNotiId = snapshot.data!.listNotiId;
          final notifications = snapshot.data!.notifications;
          return SafeArea(
            top: false,
            child: Scaffold(
              appBar: AppBar(
                bottom: const PreferredSize(
                    preferredSize: Size.zero,
                    child: Divider(
                      height: 2,
                    )),
                centerTitle: true,
                title: const Text(AppPageName.notification),
                actions: [
                  isLoadingSeeAll
                      ? const Row(
                          children: [
                            CupertinoActivityIndicator(
                              color: AppColor.light,
                            ),
                            SizedBox15W()
                          ],
                        )
                      : IconButton(
                          onPressed: () async {
                            setState(() {
                              isLoadingSeeAll = true;
                            });
                            await readAllNoti(listNotiId!);
                            await getAllNoti();
                            Future.delayed(
                                const Duration(seconds: 1, microseconds: 500),
                                () async {
                              debugPrint('See All Notices');
                              setState(() {
                                isLoadingSeeAll = false;
                              });
                              await getAllNoti();
                            });
                          },
                          icon: const Icon(Icons.done_all))
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await getAllNoti();
                },
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return NotificationItem(
                      notificationModel: notifications[index],
                    );
                  }),
                  itemCount: notifications!.length,
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            bottom: const PreferredSize(
                preferredSize: Size.zero,
                child: Divider(
                  height: 2,
                )),
            centerTitle: true,
            title: const Text(AppPageName.notification),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await getAllNoti();
              // print('object');
            },
            child: const Center(
              child: Text('Don\'t have notifications'),
            ),
          ),
        );
      },
    );
  }

  Future<void> readAllNoti(List<String> listNotiId) async {
    _notificationBlocStream.readAllNotifications(listNotiId);
  }

  Future<void> getAllNoti() async {
    _notificationBlocStream.getAllNotification();
  }
}
