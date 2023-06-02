import '../../../lib.dart';

class PersonalUpdateBloc extends BlocBase {
  @override
  void dispose() {}
  PersonalUpdateBloc(state) : super();

  static Future<void> updateProfileAndVehicleEvent(
      {required String deviceId,
      required Map<String, dynamic> userInforUpdateData,
      required Map<String, dynamic> vehicleInforUpdateData}) async {
    await PersonalInforRepo.updatePersonalInfor(userInforUpdateData);
    await DeviceRepo.updateVehicleInforOfDeviceInfor(
      deviceId: deviceId,
      vehicleInforUpdateData: vehicleInforUpdateData,
    );
  }
}
