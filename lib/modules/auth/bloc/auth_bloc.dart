import '../../../lib.dart';

class AuthBloc implements BlocBase {
  @override
  void dispose() {}

  static Future<bool> signIn() async {
    String fcmToken = await getFcmTokenFromLocalStorage() ?? '';
    DebugPrint.dataLog(currentFile: 'auth_bloc', title: 'FCM', data: fcmToken);
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
