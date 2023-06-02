import '../../../lib.dart';

class PersonalLinkUserDeviceBloc extends BlocBase {
  @override
  void dispose() {}
  PersonalLinkUserDeviceBloc(state) : super();

  static Future<void> personalLinkUserDeviceEvent(
      {required Map<String, dynamic> linkDeviceToUser}) async {
    await PersonalInforRepo.linkDeviceToUser(linkDeviceToUser);
  }
}
