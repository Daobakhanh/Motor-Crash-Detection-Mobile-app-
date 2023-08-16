import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/launcher_icon');
    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings,
    );
    await _localNotificationService.initialize(
      settings,
    );
  }

  Future<NotificationDetails> _notificationDetails(String title) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'i_safe',
      'iSafe',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      icon: '@drawable/launcher_icon',
      playSound: true,
      enableVibration: true,
    );

    return const NotificationDetails(
      android: androidNotificationDetails,
      // iOS: initializationSettingsDarwin,
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
