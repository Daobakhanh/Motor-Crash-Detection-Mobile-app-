import 'package:motorbike_crash_detection/modules/auth/repo/auth_local_storage_repo.dart';
import 'package:motorbike_crash_detection/modules/auth/repo/auth_repo.dart';
import 'package:motorbike_crash_detection/modules/providers/bloc_provider.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

import '../../app_state/repo/app_get_fcm_token_local_storage_repo.dart';
import '../model/auth_model.dart';

class AuthBloc implements BlocBase {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  static Future<bool> signIn() async {
    String fcmToken = await getFcmTokenFromLocalStorage() ?? '';
    final AuthModel? signInRes = await AuthRepo.signInRepo(fcmToken: fcmToken);
    if (signInRes!.accessToken != null) {
      await AuthLocalStorageRepo.setBackendUserAccessTokenToLocalStorage(
          accessToken: signInRes.accessToken);
      DebugPrint.dataLog(
          currentFile: 'auth_bloc',
          title: "backend accessToken",
          data: signInRes.accessToken);
      return true;
    }

    return false;
  }

  static Future<bool> signUp(Map<String, dynamic> signUpData) async {
    final AuthModel signUpRes =
        await AuthRepo.signUpRepo(signUnData: signUpData);

    if (signUpRes.accessToken != null) {
      await AuthLocalStorageRepo.setBackendUserAccessTokenToLocalStorage(
          accessToken: signUpRes.accessToken);
      return true;
    }

    return false;
  }
}
