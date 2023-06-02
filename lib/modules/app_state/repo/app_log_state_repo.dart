import 'package:shared_preferences/shared_preferences.dart';

import '../../../lib.dart';

Future<bool> isFirstAppOpen() async {
  final prefs = await SharedPreferences.getInstance();
  final String? firstOpenAppState =
      prefs.getString(SharedPrefsKey.firstOpenAppState);

  if (firstOpenAppState != null) {
    return false;
  }
  return true;
}

Future<void> saveFirstOpenAppStateToLocalStorage() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    SharedPrefsKey.firstOpenAppState,
    AppFirstOpenAppStateEnum.opened.toString(),
  );
}
