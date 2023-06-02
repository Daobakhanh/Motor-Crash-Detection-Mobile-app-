class HomeBlocEvent {
  final HomeBlocEventEnum homeBlocEvent;
  final bool? stateToggleAntiThief;
  HomeBlocEvent({required this.homeBlocEvent, this.stateToggleAntiThief});

  HomeBlocEventEnum get getEvent {
    return homeBlocEvent;
  }

  bool? get getStateToggleAntiThief {
    return stateToggleAntiThief;
  }
}

enum HomeBlocEventEnum {
  toggleAntiThief,
  getCurrentLocation,
  offWarning,
  getDeviceInfor
}
