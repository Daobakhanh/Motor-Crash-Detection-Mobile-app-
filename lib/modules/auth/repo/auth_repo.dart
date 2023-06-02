import '../../../lib.dart';

class AuthRepo {
  static Future<AuthModel> signUpRepo(
      {required Map<String, dynamic> signUnData}) async {
    try {
      final res = await DioBaseAuth.post(
        endUrl: ApiConstants.authSignUp,
        data: signUnData,
      );

      if (res.statusCode == 200) {
        DebugPrint.authenLog(
            title: 'SignUp res',
            data: res,
            currentFile: 'auth_repo',
            message: AppStateEnum.successful.toString());
        final signUpRes = AuthModel.fromJson(res.data['data']);
        return signUpRes;
      } else {
        return AuthModel();
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.authenLog(
        currentFile: "auth_repo",
        message: AppStateEnum.fail.toString(),
        title: "Auth Repo signup",
        data: e,
      );
      rethrow;
    }
    // return true;
  }

  static Future<AuthModel?> signInRepo({required String fcmToken}) async {
    try {
      final res = await DioBaseAuth.post(
        endUrl: ApiConstants.authSignIn,
        data: {
          "fcmToken": fcmToken,
        },
      );

      if (res.statusCode == 200) {
        DebugPrint.authenLog(
            currentFile: 'auth_repo',
            title: 'signIn res',
            data: res,
            message: AppStateEnum.successful.toString());
        final signInRes = AuthModel.fromJson(res.data['data']);
        return signInRes;
      } else {
        return null;
      }
    } catch (e) {
      DebugPrint.authenLog(
        message: AppStateEnum.fail.toString(),
        currentFile: 'auth_repo',
        title: "signin",
        data: e,
      );
      rethrow;
    }
  }
}
