import 'dart:async';
import 'package:motorbike_crash_detection/data/enum/app_theme_state_enum.dart';
import 'package:flutter/material.dart';

import '../../providers/bloc_provider.dart';
import '../repo/app_theme_state_local_storage.dart';

//custom Bloc
class AppThemeBloc implements BlocBase {
  @override
  void dispose() {}

  StreamController<AppThemeStateEnum> appStateBlocStreamController =
      StreamController<AppThemeStateEnum>();
  Stream<AppThemeStateEnum> get stream => appStateBlocStreamController.stream;

  AppThemeBloc() {
    readAppThemeStateFromLocalStorageAndEmitStream();
  }

  Future<void> readAppThemeStateFromLocalStorageAndEmitStream() async {
    final AppThemeStateEnum appThemeMode =
        await readAppThemeStateFromLocalStorage();

    if (appThemeMode == AppThemeStateEnum.dark) {
      appStateBlocStreamController.sink.add(AppThemeStateEnum.dark);
    } else {
      appStateBlocStreamController.sink.add(AppThemeStateEnum.light);
    }
  }

  Future<void> changeAppThemeStateAndEmitStream(bool isDarkMode) async {
    if (isDarkMode) {
      debugPrint(isDarkMode.toString());
      appStateBlocStreamController.sink.add(AppThemeStateEnum.dark);
      await saveAppThemeStateToLocalStorage(AppThemeStateEnum.dark);
    } else {
      debugPrint(isDarkMode.toString());
      appStateBlocStreamController.sink.add(AppThemeStateEnum.light);
      await saveAppThemeStateToLocalStorage(AppThemeStateEnum.light);
    }
  }
}

// //create bloc using official doc
// class AppThemeBloc extends StateStreamableSource<Object?> {
//   StreamController<AppThemeStateEnum> appStateBlocStreamController =
//       StreamController<AppThemeStateEnum>();
//   @override
//   Stream<AppThemeStateEnum> get stream => appStateBlocStreamController.stream;

//   AppThemeBloc() {
//     readAppThemeStateFromLocalStorageAndEmitStream();
//   }

//   Future<void> readAppThemeStateFromLocalStorageAndEmitStream() async {
//     final AppThemeStateEnum appThemeMode =
//         await readAppThemeStateFromLocalStorage();

//     if (appThemeMode == AppThemeStateEnum.dark) {
//       appStateBlocStreamController.sink.add(AppThemeStateEnum.dark);
//     } else {
//       appStateBlocStreamController.sink.add(AppThemeStateEnum.light);
//     }
//   }

//   Future<void> changeAppThemeStateAndEmitStream(bool isDarkMode) async {
//     if (isDarkMode) {
//       debugPrint(isDarkMode.toString());
//       appStateBlocStreamController.sink.add(AppThemeStateEnum.dark);
//       await saveAppThemeStateToLocalStorage(AppThemeStateEnum.dark);
//     } else {
//       debugPrint(isDarkMode.toString());
//       appStateBlocStreamController.sink.add(AppThemeStateEnum.light);
//       await saveAppThemeStateToLocalStorage(AppThemeStateEnum.light);
//     }
//   }

//   @override
//   FutureOr<void> close() {
//     // TODO: implement close
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement isClosed
//   bool get isClosed => throw UnimplementedError();

//   @override
//   // TODO: implement state
//   Object? get state => throw UnimplementedError();
// }
