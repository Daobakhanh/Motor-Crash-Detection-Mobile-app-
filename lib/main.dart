import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/enum/app_state_enum.dart';
import 'firebase/firebase_options.dart';
import 'modules/app_state/bloc/app_state_bloc.dart';
import 'modules/auth/page/auth_page.dart';
import 'modules/bloc/bloc_observer/chatty_bloc_observer.dart';
import 'modules/navigation/pages/app_navigation.dart';
import 'modules/providers/bloc_provider.dart';
import 'route/app_route.dart';
import 'themes/app_color.dart';
import 'themes/app_font.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = AppBlocObserver();
  Bloc.observer = ChattyBlocObserver();

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _appStateStreamControllerBloc.dispose();
    _appAuthStateStreamControllerBloc.dispose();
  }

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
