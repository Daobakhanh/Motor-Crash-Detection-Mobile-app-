import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = ChattyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  await firebaseInitial();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AppThemeBloc _appStateStreamControllerBloc = AppThemeBloc();
  final AppAuthStateBloc _appAuthStateStreamControllerBloc = AppAuthStateBloc();

  @override
  void dispose() {
    super.dispose();
    _appStateStreamControllerBloc.dispose();
    _appAuthStateStreamControllerBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _appStateStreamControllerBloc,
      child: StreamBuilder<AppThemeStateEnum>(
          stream: _appStateStreamControllerBloc.stream,
          builder: ((context, snapshot) {
            return MaterialApp(
              onGenerateRoute: AppRoute.generateRoute,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // scaffoldBackgroundColor: AppColors.grey3,
                pageTransitionsTheme: const PageTransitionsTheme(builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                }),
                colorSchemeSeed: const Color(0xff727688),
                brightness: snapshot.data == AppThemeStateEnum.light
                    ? Brightness.light
                    : Brightness.dark,
                fontFamily: AppFont.fontNotoSans,
                useMaterial3: true,
                appBarTheme: AppBarTheme(
                  titleTextStyle: AppTextStyle.body20.copyWith(
                    fontWeight: FontWeight.bold,
                    color: snapshot.data == AppThemeStateEnum.dark
                        ? AppTextColor.light
                        : AppTextColor.dark,
                  ),
                  // color: snapshot.data == AppThemeStateEnum.dark
                  //     ? AppColor.greyBold
                  //     : AppColor.grey,
                  centerTitle: true,
                ),
              ),
              home: BlocProvider(
                bloc: _appAuthStateStreamControllerBloc,
                child: StreamBuilder<AppAuthStateEnum>(
                  stream: _appAuthStateStreamControllerBloc.appAuthStateStream,
                  initialData:
                      _appAuthStateStreamControllerBloc.initAppAuthState,
                  builder: ((context, snapshot) {
                    if (snapshot.data == AppAuthStateEnum.authorized) {
                      return const AppNavigationConfig();
                    } else if (snapshot.data == AppAuthStateEnum.unAuthorized) {
                      return BlocProvider(
                        bloc: _appAuthStateStreamControllerBloc,
                        child: const AuthPage(),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                      // child: AppNavigationConfig(),
                    );
                  }),
                ),
              ),
            );
          })),
    );
  }
}
