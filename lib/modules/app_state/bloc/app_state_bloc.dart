import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../lib.dart';

//custom Bloc
class AppThemeBloc implements BlocBase {
  StreamController<AppThemeStateEnum> appStateBlocStreamController =
      StreamController<AppThemeStateEnum>();
  Stream<AppThemeStateEnum> get stream => appStateBlocStreamController.stream;

  AppThemeBloc() {
    readAppThemeStateFromLocalStorageAndEmitStream();
  }
  @override
  void dispose() {
    appStateBlocStreamController.close();
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

class AppAuthStateBloc implements BlocBase {
  //create Stream controler
  StreamController<AppAuthStateEnum> appStateStreamController =
      StreamController<AppAuthStateEnum>.broadcast();

  //getter stream from stream controller
  Stream<AppAuthStateEnum> get appAuthStateStream =>
      appStateStreamController.stream;

  //initial state
  AppAuthStateEnum get initAppAuthState => AppAuthStateEnum.loading;

  @override
  void dispose() {
    // appStateStreamController.close();
  }

  AppAuthStateBloc() {
    launchApp();
  }

  Future<void> launchApp() async {
    final isBackendUserTokenExpried =
        await PersonalInforRepo.isBackendUserAccessTokenExpired();

    //get device infor, save device ID to local storage
    await DeviceRepo.getDevice();

    await changeAppAuthState(isUserTokenExpired: isBackendUserTokenExpried);
    // String fcm = await getFcmTokenFromLocalStorage() ?? '';
    // DebugPrint.dataLog(currentFile: 'app_state_bloc', title: 'fcm', data: fcm);
  }

  Future<void> changeAppAuthState({required bool isUserTokenExpired}) async {
    // final storePref = await SharedPreferences.getInstance();

    if (isUserTokenExpired) {
      //expried = out date
      appStateStreamController.sink.add(AppAuthStateEnum.unAuthorized);
    } else {
      appStateStreamController.sink.add(AppAuthStateEnum.authorized);
    }
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(SharedPrefsKey.backendUserAccessToken);
    await changeAppAuthState(isUserTokenExpired: true);
    DebugPrint.authenLog(
      currentFile: 'app_state_bloc',
      title: 'Logout and remove accessToken',
      message: AppStateEnum.successful.toString(),
    );
  }
}
