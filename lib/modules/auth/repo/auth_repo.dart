import 'package:motorbike_crash_detection/base/dio_base.dart';
import 'package:motorbike_crash_detection/data/term/network_term.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

import '../../../model/user/user_model.dart';

class AuthRepo {
  static Future<void> signUp({required Map<String, dynamic> signUnData}) async {
    try {
      final res = await DioBase.post(
        endUrl: ApiConstants.authSignUp,
        data: signUnData,
      );

      if (res.statusCode == 200) {
        DebugPrint.dataLog(title: 'SignUp res', data: res);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    // return true;
  }

  static Future<void> signIn({required String fcmToken}) async {
    try {
      final res = await DioBase.post(
        endUrl: ApiConstants.authSignIn,
        data: {
          "fcmToken": fcmToken,
        },
      );

      if (res.statusCode == 200) {
        DebugPrint.dataLog(title: 'signIn res', data: res);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    // return true;
  }
}
