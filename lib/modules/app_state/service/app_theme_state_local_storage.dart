import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/enum/app_theme_state_enum.dart';
import '../../../common/term/local_storage_pref_key.dart';

Future<AppThemeStateEnum> readAppThemeStateFromLocalStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final String? appThemeMode = prefs.getString(PrefsKey.appThemeMode);

  if (appThemeMode == AppThemeStateEnum.dark.toString()) {
    return AppThemeStateEnum.dark;
  } else {
    return AppThemeStateEnum.light;
  }
}

Future<void> saveAppThemeStateToLocalStorage(
    AppThemeStateEnum appThemeStateEnum) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(PrefsKey.appThemeMode, appThemeStateEnum.toString());
}
