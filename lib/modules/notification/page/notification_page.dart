import 'package:flutter/material.dart';

import '../../../data/term/app_term.dart';
import '../widget/notification_item_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppRouteName.notification),
          actions: [
            IconButton(
                onPressed: () {
                  debugPrint('See All Notices');
                },
                icon: const Icon(Icons.done_all))
          ],
        ),
        body: ListView.builder(
          itemBuilder: ((context, index) {
            return NotificationItem(
              isRead: (index == 10 || index == 3) ? false : true,
            );
          }),
          itemCount: 20,
        ));
  }
}
