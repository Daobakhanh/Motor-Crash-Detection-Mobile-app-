import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getFcmTokenFromLocalStorage() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken;

  //TODO:
  //Uncomment if build apk app
  // // save fcm token to local storage
  // final prefs = await SharedPreferences.getInstance();
  // fcmToken = prefs.getString(SharedPrefsKey.fcmToken);
  // if (fcmToken == null) {
  //   fcmToken = await firebaseMessaging.getToken();
  //   await prefs.setString(SharedPrefsKey.fcmToken, fcmToken.toString());
  //   return fcmToken;
  // } else {
  //   fcmToken = await firebaseMessaging.getToken();
  //   await prefs.setString(SharedPrefsKey.fcmToken, fcmToken.toString());
  //   return fcmToken;
  // }

  //feature of dev app, get new fcm
  fcmToken = await firebaseMessaging.getToken();
  return fcmToken;
}
