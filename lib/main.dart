import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_crash_detection/model/fcm/fcm_noti_model.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

import 'base/notification_service.dart';
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
  Bloc.observer = ChattyBlocObserver();

  //Firebase initial
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //FCM Config
  // FirebaseMessaging fbMessaging = FirebaseMessaging.instance;
  final LocalNotificationService fcmService = LocalNotificationService();

  // await fbMessaging.setForegroundNotificationPresentationOptions(
  //   alert: true, // Required to display a heads up notification
  //   badge: true,
  //   sound: true,
  // );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      debugPrint('Got a message whilst in the foreground!');
      // debugPrint('Message data: ${message.data}');
      debugPrint('Message notification: ${message.notification!.title}');
      await fcmService.initialize();

      await fcmService.showNotification(
          id: 0,
          title: message.notification!.title ?? 'iSafe',
          body: message.notification!.body ?? 'iSafe');
    },
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // // If you're going to use other Firebase services in the background, such as Firestore,
  // // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  // debugPrint("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp();
  debugPrint(
      'Handling a background message, notification ${message.notification}');
  late final LocalNotificationService service;
  service = LocalNotificationService();
  await service.initialize();

  //if have data, uncomment code below
  // FcmNotiModel noti = FcmNotiModel();
  // final Map<String, dynamic> result = Map<String, dynamic>.from(message.data);
  // noti = FcmNotiModel.fromJson(result);
  await service.showNotificationWithPayload(
    id: 1,
    title: message.notification!.title ?? 'iSafe',
    body: message.notification!.body ?? 'iSafe',
    payload: 'payload navigation',
  );
}
