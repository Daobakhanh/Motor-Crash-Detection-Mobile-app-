import 'dart:io';
// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
// import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
// import 'package:http/http.dart' as http;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/app_logo');

    // final IOSInitializationSettings iosInitializationSettings =
    //     IOSInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: true,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );

    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      // onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails(String title) async {
    // final bigPicturePath = await Utils.downloadFile(
    //     'https://static.wikia.nocookie.net/onepunchman/images/2/27/Saitama.png/revision/latest?cb=20210530114318&path-prefix=vi',
    //     'bigPicturePath');
    // final iconPath = await ImageLocal.saveFile('iconPath');

    //use when noti have image
    // final styleInformation = BigPictureStyleInformation(
    //     FilePathAndroidBitmap(bigPicturePath),
    //     largeIcon: FilePathAndroidBitmap(iconPath),
    //     contentTitle: title);
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'i_safe',
      'iSafe',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      // styleInformation: styleInformation,
      icon: '@drawable/app_logo',
      playSound: true,
      enableVibration: true,
    );

    // const IOSNotificationDetails iosNotificationDetails =
    //     IOSNotificationDetails(
    //   presentAlert: true,
    //   presentBadge: true,
    //   presentSound: true,
    // );

    return const NotificationDetails(
      android: androidNotificationDetails,
      // iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails(title);
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails(title);
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    debugPrint('id $id');
  }

  void onSelectNotification(String? payload) {
    debugPrint('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }
}
