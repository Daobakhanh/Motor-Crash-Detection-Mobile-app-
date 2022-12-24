import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/term/local_storage_pref_key.dart';

Future<void> setFbUserAccessTokenToLocalStorage(
    {required String accessToken}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(SharedPrefsKey.firebaseUserAccessToken, accessToken);
}

Future<String?> getFbUserAccessTokenFromLocalStorage() async {
  String? accessToken;
  final prefs = await SharedPreferences.getInstance();
  accessToken = prefs.getString(SharedPrefsKey.firebaseUserAccessToken);
  return accessToken;
}
