import 'package:motorbike_crash_detection/modules/notification/model/notification_model.dart';

import '../../../base/dio_base.dart';
import '../../../data/term/network_term.dart';
import '../../../utils/debug_print_message.dart';

class NotificationRepo {
  static Future<List<NotificationModel>?> getAllNotifications() async {
    try {
      final res = await DioBase.get(
        endUrl: ApiConstants.getAllNoti,
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
          currentFile: "notification_repo",
          message: 'getAllNoti',
        );
        List<dynamic> listNotiJson = res.data['data']; //list noti json

        return listNotiJson
            .map((json) => NotificationModel.fromJson(json))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'notification_repo',
        title: "getAllNoti",
        data: e,
      );
      // rethrow;
    }
    return null;
    // return listNoti;
  }

  static Future<bool> readAllNotifications(
      {required List<String> listNotiId}) async {
    try {
      final res = await DioBase.put(
        data: {
          "ids": listNotiId,
          "isRead": true,
        },
        endUrl: ApiConstants.seeAllNoti,
      );

      if (res.statusCode == 200) {
        DebugPrint.dataLog(
          data: null,
          title: 'read all noti successful',
          currentFile: "notification_repo",
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'notification_repo',
        title: "getAllNoti",
        data: e,
      );
      // rethrow;
    }
    return false;
    //
  }
}
