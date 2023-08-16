import 'dart:async';

import '../../../lib.dart';

class NotificationBlocStream implements BlocBase {
  @override
  void dispose() {}

  NotificationBlocStream() {
    getAllNotification();
  }

  StreamController<NotificationBlocStreamState> notificationStreamController =
      StreamController<NotificationBlocStreamState>.broadcast();

  Stream<NotificationBlocStreamState> get notiStream =>
      notificationStreamController.stream;

  Future<void> getAllNotification() async {
    try {
      final notificationsRes = await NotificationRepo.getAllNotifications();
      if (notificationsRes != null) {
        List<String> listNotiId = [];

        for (var element in notificationsRes) {
          listNotiId.add(element.id!);
        }

        notificationStreamController.add(
          NotificationBlocStreamState(
              notifications: notificationsRes, listNotiId: listNotiId),
        );

        DebugPrint.dataLog(
          currentFile: 'notification_stream_bloc',
          title: 'event getAllNotifications true',
          data: notificationsRes.toString(),
        );
      } else {
        DebugPrint.dataLog(
          currentFile: 'notification_stream_bloc',
          title: 'event getAllNoti false, res null',
          data: null,
        );
      }
    } catch (e) {
      // notificationStreamController.add(NotificationBlocStreamState(error: e));
      DebugPrint.dataLog(
        currentFile: 'notification_stream_bloc',
        title: 'event getAllNoti false',
        data: e,
      );
    }
  }

  Future<bool> readAllNotifications(List<String> listNotiId) async {
    try {
      final notificationsRes = await NotificationRepo.readAllNotifications(
        listNotiId: listNotiId,
      );
      if (notificationsRes) {
        DebugPrint.dataLog(
          currentFile: 'notification_stream_bloc',
          title: 'event readAllNoti successful',
          data: null,
        );
        return true;
      }
      return false;
    } catch (e) {
      // notificationStreamController.add(NotificationBlocStreamState(error: e));
      DebugPrint.dataLog(
        currentFile: 'notification_stream_bloc',
        title: 'event readAllNoti false',
        data: e,
      );
      return false;
    }
  }
}

class NotificationBlocStreamState {
  final List<NotificationModel>? notifications;
  final List<String>? listNotiId;
  final Object? error;
  NotificationBlocStreamState({
    this.listNotiId,
    this.notifications,
    this.error,
  });
}
