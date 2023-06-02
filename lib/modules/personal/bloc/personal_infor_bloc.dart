import 'package:bloc/bloc.dart';

import '../../../lib.dart';

class PersonalInforBloc extends Bloc<PersonalBlocEvent, PersonalInforState> {
  //String: event
  //PersonalInforState: state
  PersonalInforBloc() : super(PersonalInforState()) {
    on<PersonalBlocEvent>(
      ((event, emit) async {
        switch (event.getPersonalEvent) {
          case PersonalInforBlocEventTitle.getPersonalInfor:
            try {
              final personalRes = await PersonalInforRepo.getUserInfor();
              final deviceRes = await DeviceRepo.getDevice();
              if (personalRes != null) {
                emit(PersonalInforState(user: personalRes));
                if (deviceRes != null) {
                  emit(
                      PersonalInforState(user: personalRes, device: deviceRes));
                }
              }
            } catch (e) {
              emit(PersonalInforState(error: e));
              DebugPrint.dataLog(
                  currentFile: 'personal_infor_bloc',
                  title: 'event getPersonalInfor false',
                  data: e);
            }
            break;
          case PersonalInforBlocEventTitle.updatePersonalInfor:
            break;
        }
      }),
    );
  }
}

class PersonalInforState {
  final UserModel? user;
  final DeviceModel? device;
  final Object? error;
  PersonalInforState({this.user, this.error, this.device});
}
