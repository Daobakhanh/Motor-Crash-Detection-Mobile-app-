import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getFcmTokenFromLocalStorage() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken = '';

  //don't save fcm to local storage
  fcmToken = await firebaseMessaging.getToken();
  return fcmToken;

  //save fcm token to local storage
  // final prefs = await SharedPreferences.getInstance();
  // fcmToken = prefs.getString(PrefsKey.fcmToken);
  // if (fcmToken == null) {
  //   fcmToken = await firebaseMessaging.getToken();
  //   await prefs.setString(PrefsKey.fcmToken, fcmToken.toString());
  //   return fcmToken;
  // } else {
  //   fcmToken = await firebaseMessaging.getToken();
  //   await prefs.setString(PrefsKey.fcmToken, fcmToken.toString());
  //   return fcmToken;
  // }
}
