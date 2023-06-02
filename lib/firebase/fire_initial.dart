import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../lib.dart';

Future<void> firebaseInitial() async {
  //Firebase initial
  await Firebase.initializeApp(
    name: "motorbike-crash-theft-detect",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _fcmConfig();
}

Future<void> _fcmConfig() async {
  // FirebaseMessaging fbMessaging = FirebaseMessaging.instance;
  final LocalNotificationService fcmService = LocalNotificationService();

  // await fbMessaging.setForegroundNotificationPresentationOptions(
  //   alert: true, // Required to display a heads up notification
  //   badge: true,
  //   sound: true,
  // );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      debugPrint('Got a message whilst in the foreground!');
      // debugPrint('Message data: ${message.data}');
      debugPrint('Message notification: ${message.notification!.title}');
      await fcmService.initialize();

      await fcmService.showNotification(
          id: 0,
          title: message.notification!.title ?? 'iSafe',
          body: message.notification!.body ?? 'iSafe');
    },
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // // If you're going to use other Firebase services in the background, such as Firestore,
  // // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  // debugPrint("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp();
  debugPrint(
      'Handling a background message, notification ${message.notification}');
  late final LocalNotificationService service;
  service = LocalNotificationService();
  await service.initialize();

  //if have data, uncomment code below
  // FcmNotiModel noti = FcmNotiModel();
  // final Map<String, dynamic> result = Map<String, dynamic>.from(message.data);
  // noti = FcmNotiModel.fromJson(result);
  await service.showNotificationWithPayload(
    id: 1,
    title: message.notification!.title ?? 'iSafe',
    body: message.notification!.body ?? 'iSafe',
    payload: 'payload navigation',
  );
}
