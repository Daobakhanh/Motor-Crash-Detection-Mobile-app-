import 'package:motorbike_crash_detection/data/enum/app_state_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/term/local_storage_pref_key.dart';

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
