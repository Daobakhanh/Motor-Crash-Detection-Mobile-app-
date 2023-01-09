import 'package:motorbike_crash_detection/modules/device/repo/device_repo.dart';
import 'package:motorbike_crash_detection/modules/providers/bloc_provider.dart';

import '../repo/personal_infor_repo.dart';

class PersonalLinkUserDeviceBloc extends BlocBase {
  @override
  void dispose() {}
  PersonalLinkUserDeviceBloc(state) : super();

  static Future<void> personalLinkUserDeviceEvent(
      {required Map<String, dynamic> linkDeviceToUser}) async {
    await PersonalInforRepo.linkDeviceToUser(linkDeviceToUser);
  }
}
