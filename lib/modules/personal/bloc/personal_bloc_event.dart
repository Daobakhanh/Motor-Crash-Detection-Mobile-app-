class PersonalBlocEvent {
  final String? deviceId;
  final PersonalInforBlocEventTitle event;

  String? get getDeviceId {
    return deviceId;
  }

  PersonalInforBlocEventTitle get getPersonalEvent {
    return event;
  }

  PersonalBlocEvent({this.deviceId, required this.event});
}

enum PersonalInforBlocEventTitle { getPersonalInfor, updatePersonalInfor }
