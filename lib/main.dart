import 'package:bloc/bloc.dart';
import 'package:motorbike_crash_detection/data/enum/app_state_enum.dart';
import 'package:motorbike_crash_detection/firebase/firebase_options.dart';
import 'package:motorbike_crash_detection/modules/providers/bloc_provider.dart';
import 'package:motorbike_crash_detection/route/app_route.dart';
import 'package:motorbike_crash_detection/themes/app_font.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'modules/app_state/bloc/app_state_bloc.dart';
import 'modules/auth/page/auth_page.dart';
import 'modules/bloc/bloc_observer/app_bloc_observer.dart';
import 'modules/navigation/pages/app_navigation.dart';
import 'themes/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final _appStateStreamControllerBloc = AppThemeBloc();
  final _appAuthStateStreamControllerBloc = AppAuthStateBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _appStateStreamControllerBloc,
      child: StreamBuilder<AppThemeStateEnum>(
          // initialData: AppThemeStateEnum.light,
          stream: _appStateStreamControllerBloc.stream,
          builder: ((context, snapshot) {
            return MaterialApp(
              onGenerateRoute: AppRoute.generateRoute,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: snapshot.data == AppThemeStateEnum.light
                    ? Brightness.light
                    : Brightness.dark,
                fontFamily: AppFont.avenir,
                primarySwatch: Colors.pink,
                appBarTheme: const AppBarTheme(
                  color: AppColor.greyBold,
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
                          child: const AuthPage());
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ),
              ),
            );
          })),
    );
  }
}
