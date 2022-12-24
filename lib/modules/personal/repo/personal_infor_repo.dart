import 'package:motorbike_crash_detection/base/dio_base.dart';
import 'package:motorbike_crash_detection/model/user/user_model.dart';

import '../../../data/term/network_term.dart';
import '../../../utils/debug_print_message.dart';

class PersonalInforRepo {
  static Future<bool> isBackendUserAccessTokenExpired() async {
    try {
      final res = await DioBase.get(
        endUrl: ApiConstants.userGetInfor,
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            currentFile: 'Personal_infor_repo',
            httpMethod: 'get',
            message: 'Personal',
            url: ApiConstants.userGetInfor);
        return false;
      } else {
        return true;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'Personal_infor_repo',
        title: "Personal Repo get infor error",
        data: e,
      );
      // rethrow;
    }
    return true;
  }

  static Future<UserModel?> getUserInfor() async {
    try {
      final res = await DioBase.get(
        endUrl: ApiConstants.userGetInfor,
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            currentFile: "personal_infor_repo", message: 'getUserInfor');
        final signUpRes = UserModel.fromJson(res.data['data']);
        return signUpRes;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'personal_infor_repo',
        title: "get infor error",
        data: e,
      );
      // rethrow;
    }
    return null;
  }
}
