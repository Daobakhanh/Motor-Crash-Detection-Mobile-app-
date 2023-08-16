import '../../../lib.dart';

class HomeRepo {
  static Future<DeviceModel?> toggleAntiThief({required bool antiTheft}) async {
    try {
      //get device ID from local storage here
      String deviceId = await DeviceRepo.getDeviceIdFromLocalStorage() ?? '';
      DebugPrint.dataLog(
          currentFile: 'home_repo',
          title: 'toggleAntiTheft state pass from home',
          data: antiTheft);
      final res = await DioBase.post(
        data: {
          "antiTheft": antiTheft,
          "updateLocation": true,
          "warning": false
        },
        endUrl: ApiConstants.requestDevice(deviceId: deviceId),
      );
      DebugPrint.callApiLog(
        currentFile: "home_repo",
        message: 'toggleAntiThief successfull',
      );
      final resDevice = DeviceModel.fromJson(res.data['data']);
      return resDevice;
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'home_repo',
        title: "toggleAntiThief",
        data: e,
      );
      // rethrow;
    }
    return null;
    // return listNoti;
  }

  static Future<DeviceModel?> getCurrentLocation(
      {required bool antiTheft}) async {
    //call for socket io push
    try {
      //get device ID from local storage here
      String deviceId = await DeviceRepo.getDeviceIdFromLocalStorage() ?? '';

      final res = await DioBase.post(
        data: {
          "updateLocation": true,
          "antiTheft": antiTheft,
          "warning": false
        },
        endUrl: ApiConstants.requestDevice(deviceId: deviceId),
      );

      DebugPrint.callApiLog(
        currentFile: "home_repo",
        message: 'getCurrentLocation successfull',
      );

      final resDevice = DeviceModel.fromJson(res.data['data']);

      return resDevice;
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'home_repo',
        title: "getCurrentLocation fail",
        data: e,
      );
      // rethrow;
    }
    return null;
    // return listNoti;
  }

  static Future<DeviceModel?> offWarning({required bool antiTheft}) async {
    //call for socket io push
    try {
      //get device ID from local storage here
      String deviceId = await DeviceRepo.getDeviceIdFromLocalStorage() ?? '';
      final res = await DioBase.post(
        //fasle to of warning
        data: {
          "warning": false,
          "antiTheft": antiTheft,
          "updateLocation": true
        },
        endUrl: ApiConstants.requestDevice(deviceId: deviceId),
      );

      DebugPrint.callApiLog(
        currentFile: "home_repo",
        message: 'offWarning successfull',
      );

      final resDevice = DeviceModel.fromJson(res.data['data']);

      return resDevice;
    } catch (e) {
      // ignore: avoid_print
      DebugPrint.dataLog(
        currentFile: 'home_repo',
        title: "offWarning false",
        data: e,
      );
      // rethrow;
    }
    return null;
    // return listNoti;
  }
}
