import 'package:shared_preferences/shared_preferences.dart';

import '../../../lib.dart';

class DeviceRepo {
  static Future<DeviceModel?> getDevice() async {
    try {
      final res = await DioBase.get(
        endUrl: ApiConstants.deviceGetInfor,
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(currentFile: "device_repo", message: 'getDevice');

        if (res.data['data'].length != 0) {
          final device = DeviceModel.fromJson(
              res.data['data'][0]); //res list device, but get once
          await saveDeviceIdToLocalStorage(deviceID: device.id!);
          return device;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      // rethrow;
    }
    return null;
  }

  static Future<VehicleDataModel?> getVehicle() async {
    try {
      final res = await DioBase.get(
        endUrl: ApiConstants.deviceGetInfor,
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            currentFile: "device_repo", message: 'getVehicle');
        final device = VehicleDataModel.fromJson(
            res.data['data'][0]['vehicle']); //res list device, but get once
        return device;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'device_repo',
        title: "getVehicle error",
        data: e,
      );
      // rethrow;
    }
    return null;
  }

  static Future<bool> linkDeviceToUser(
      {required String deviceId, required String verificationCode}) async {
    try {
      final res = await DioBase.post(
        data: {'deviceId': deviceId, 'verificationCode': verificationCode},
        endUrl: ApiConstants.deviceLinkToUser,
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            currentFile: "device_repo", message: 'linkDeviceToUser');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'device_repo',
        title: "linkDeviceToUser error",
        data: e,
      );
      // rethrow;
    }
    return false;
  }

  static Future<DeviceModel?> updateVehicleInforOfDeviceInfor(
      {required String deviceId,
      required Map<String, dynamic> vehicleInforUpdateData}) async {
    try {
      final res = await DioBase.put(
        data: vehicleInforUpdateData,
        //don't update photoUrlHere

        endUrl: '/devices/$deviceId',
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            httpMethod: 'put',
            currentFile: "device_repo",
            url: '/devices/$deviceId',
            message: 'updateDevice',
            data: res.data);

        final device = DeviceModel.fromJson(
            res.data['data'][0]); //res list device, but get once
        return device;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'device_repo',
        title: "updateDevice error",
        data: e,
      );
      // rethrow;
    }
    return null;
  }

  static Future<DeviceModel?> updateDeviceWarningStatus({
    required String deviceId,
  }) async {
    try {
      final res = await DioBase.put(
        data: {"status": 0},
        endUrl: ApiConstants.deviceUpdateInfor(deviceId: deviceId),
      );

      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            currentFile: "device_repo", message: 'updateDeviceWarningStatus');

        final device = DeviceModel.fromJson(
            res.data['data']); //res list device, but get once
        return device;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'device_repo',
        title: "updateDeviceWarningStatus error",
        data: e,
      );
      // rethrow;
    }
    return null;
  }

  static Future<DeviceModel?> updateDevicePhoto(
      {required String deviceId, required String photoUrl}) async {
    try {
      final res = await DioBase.put(
        data: {
          "vehicle": {"photoUrl": photoUrl},
        },
        endUrl: ApiConstants.deviceUpdateInfor(deviceId: deviceId),
      );
      if (res.statusCode == 200) {
        DebugPrint.callApiLog(
            currentFile: "device_repo", message: 'updateDevicePhoto');
        final device = DeviceModel.fromJson(
            res.data['data'][0]); //res list device, but get once
        return device;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'device_repo',
        title: "updateDevicePhoto error",
        data: e,
      );
      // rethrow;
    }
    return null;
  }

  static Future<void> saveDeviceIdToLocalStorage(
      {required String deviceID}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefsKey.deviceID, deviceID);
  }

  static Future<String?> getDeviceIdFromLocalStorage() async {
    String? deviceId;
    final prefs = await SharedPreferences.getInstance();
    deviceId = prefs.getString(SharedPrefsKey.deviceID);
    return deviceId;
  }
}
