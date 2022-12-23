import 'package:motorbike_crash_detection/common/enum/app_theme_state_enum.dart';
import 'package:motorbike_crash_detection/firebase_options.dart';
import 'package:motorbike_crash_detection/modules/providers/bloc_provider.dart';
import 'package:motorbike_crash_detection/themes/app_font.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'modules/app_state/bloc/app_state_bloc.dart';
import 'modules/auth/page/auth_page.dart';
import 'themes/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final _appStateStreamController = AppThemeBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _appStateStreamController,
      child: StreamBuilder<AppThemeStateEnum>(
          // initialData: AppThemeStateEnum.light,
          stream: _appStateStreamController.stream,
          builder: ((context, snapshot) {
            return MaterialApp(
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
                home: const AuthPage());
          })),
    );
  }
}
