import 'package:bloc/bloc.dart';

import '../../../lib.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  //String: event
  //PersonalInforState: state
  HomeBloc() : super(HomeBlocState()) {
    on<HomeBlocEvent>(
      ((event, emit) async {
        switch (event.getEvent) {
          case HomeBlocEventEnum.toggleAntiThief:
            try {
              HomeBlocState(isLoading: true, isLoadDone: false);
              DeviceModel? resDevice = await HomeRepo.toggleAntiThief(
                  antiTheft: event.getStateToggleAntiThief!);

              // final deviceRes = await DeviceRepo.getDevice();
              if (resDevice != null) {
                emit(
                  HomeBlocState(
                      device: resDevice, isLoadDone: true, isLoading: false),
                );
              }
            } catch (e) {
              emit(
                HomeBlocState(error: e, isLoadDone: true, isLoading: false),
              );
              DebugPrint.dataLog(
                  currentFile: 'home_bloc',
                  title: 'event toggleAntiThief false',
                  data: e);
            }
            break;
          case HomeBlocEventEnum.getCurrentLocation:
            try {
              HomeBlocState(isLoading: true, isLoadDone: false);
              DeviceModel? resDevice = await HomeRepo.getCurrentLocation(
                  antiTheft: event.getStateToggleAntiThief!);
              // final deviceRes = await DeviceRepo.getDevice();
              if (resDevice != null) {
                emit(
                  HomeBlocState(
                      device: resDevice, isLoadDone: true, isLoading: false),
                );
              }
            } catch (e) {
              emit(
                HomeBlocState(error: e, isLoadDone: true, isLoading: false),
              );
              DebugPrint.dataLog(
                  currentFile: 'home_bloc',
                  title: 'event getCurrentLocation false',
                  data: e);
            }
            break;
          case HomeBlocEventEnum.offWarning:
            try {
              HomeBlocState(isLoading: true, isLoadDone: false);
              DeviceModel? resDevice = await HomeRepo.offWarning(
                  antiTheft: event.getStateToggleAntiThief!);
              // final deviceRes = await DeviceRepo.getDevice();
              if (resDevice != null) {
                emit(
                  HomeBlocState(
                      device: resDevice, isLoadDone: true, isLoading: false),
                );
              }
            } catch (e) {
              emit(
                HomeBlocState(error: e, isLoadDone: true, isLoading: false),
              );
              DebugPrint.dataLog(
                  currentFile: 'home_bloc',
                  title: 'event offWarning false',
                  data: e);
            }
            break;
          case HomeBlocEventEnum.getDeviceInfor:
            try {
              HomeBlocState(isLoading: true, isLoadDone: false);

              final deviceRes = await DeviceRepo.getDevice();
              if (deviceRes != null) {
                emit(
                  HomeBlocState(
                      device: deviceRes, isLoadDone: true, isLoading: false),
                );
              }
            } catch (e) {
              emit(
                HomeBlocState(error: e, isLoadDone: true, isLoading: false),
              );
              DebugPrint.dataLog(
                  currentFile: 'home_bloc',
                  title: 'event getDeviceInfor false',
                  data: e);
            }
            break;
        }
      }),
    );
  }
}

class HomeBlocState {
  final bool? isLoading;
  final bool? isLoadDone;
  final DeviceModel? device;
  final Object? error;
  HomeBlocState({this.error, this.device, this.isLoading, this.isLoadDone});
}
