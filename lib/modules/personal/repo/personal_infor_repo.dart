import 'package:motorbike_crash_detection/base/dio_base.dart';
import 'package:motorbike_crash_detection/data/term/app_term.dart';
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
        DebugPrint.dataLog(
            currentFile: 'personal_infor',
            title: 'be user token actice',
            data: true);
        // final signUpRes = UserModel.fromJson(res.data['data']);

        return false;
      } else {
        DebugPrint.callApiLog(
            currentFile: 'Personal_infor_repo',
            httpMethod: 'get',
            message: 'Personal',
            url: ApiConstants.userGetInfor);
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

  static Future<void> updatePersonalInfor(
    Map<String, dynamic> userInforUpdateData,
  ) async {
    try {
      final res = await DioBase.put(
        data: userInforUpdateData,
        endUrl: ApiConstants.userUpdateInfor,
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            httpMethod: 'put',
            url: '/users/me',
            currentFile: "personal_infor_repo",
            data: res.data,
            message: 'updateDevice');
      } else {}
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'personal_infor_repo',
        title: "updateDevice error",
        data: e,
      );
      // rethrow;
    }
  }

  static Future<void> linkDeviceToUser(
    Map<String, dynamic> linkDeviceToUser,
  ) async {
    try {
      final res = await DioBase.post(
        data: linkDeviceToUser,
        endUrl: ApiConstants.deviceLinkToUser,
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            httpMethod: 'post',
            url: ApiConstants.deviceLinkToUser,
            currentFile: "personal_infor_repo",
            data: res.data,
            message: 'linkDeviceToUser');
      } else {}
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'personal_infor_repo',
        title: "linkDeviceToUser error",
        data: e,
      );
      // rethrow;
    }
  }
}
