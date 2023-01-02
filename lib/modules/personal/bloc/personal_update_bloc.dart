import 'package:motorbike_crash_detection/modules/device/repo/device_repo.dart';
import 'package:motorbike_crash_detection/modules/providers/bloc_provider.dart';

import '../repo/personal_infor_repo.dart';

class PersonalUpdateBloc extends BlocBase {
  @override
  void dispose() {
    // TODO: implement dispose
  }
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
