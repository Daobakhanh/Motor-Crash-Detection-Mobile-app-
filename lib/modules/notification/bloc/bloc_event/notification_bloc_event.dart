class NotificationBlocEvent {
  final NotificationEventEnum notificationBlocEvent;
  final List<String>? listNotiId;
  NotificationBlocEvent({required this.notificationBlocEvent, this.listNotiId});
  NotificationEventEnum get getNotiBlocEvent {
    return notificationBlocEvent;
  }

  List<String>? get getListNotiId {
    return listNotiId;
  }
}

enum NotificationEventEnum { getAllNoti, seeAllNoti, seeNotiWithId }
