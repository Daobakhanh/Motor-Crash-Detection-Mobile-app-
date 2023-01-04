import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/modules/providers/bloc_provider.dart';
import 'package:motorbike_crash_detection/modules/widget/widget/stateless_widget/sized_box_widget.dart';

import '../../../data/term/app_term.dart';
import '../../../themes/app_color.dart';
import '../bloc/notification_stream_bloc.dart';
import '../widget/notification_item_widget.dart';

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
    return BlocProvider(
      bloc: _notificationBlocStream,
      child: StreamBuilder<NotificationBlocStreamState>(
        stream: _notificationBlocStream.notiStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.notifications != null) {
            final listNotiId = snapshot.data!.listNotiId;
            final notifications = snapshot.data!.notifications;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(AppPageName.notification),
                actions: [
                  isLoadingSeeAll
                      ? Row(
                          children: const [
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
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> readAllNoti(List<String> listNotiId) async {
    _notificationBlocStream.readAllNotifications(listNotiId);
  }

  Future<void> getAllNoti() async {
    _notificationBlocStream.getAllNotification();
  }
}
