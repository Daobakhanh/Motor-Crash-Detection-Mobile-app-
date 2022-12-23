import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/term/local_storage_pref_key.dart';

Future<void> setAccessTokenToLocalStorage({required String accessToken}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(PrefsKey.userAccessToken, accessToken);
}

Future<String?> getAccessTokenFromLocalStorage() async {
  String? accessToken;
  final prefs = await SharedPreferences.getInstance();
  accessToken = prefs.getString(PrefsKey.userAccessToken);
  return accessToken;
}
