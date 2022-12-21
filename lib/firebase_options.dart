// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAeAEPAaPXM_WC64ilHML7oey8jCa6Du1o',
    appId: '1:737258673931:web:e24ae5d80115858c3d740e',
    messagingSenderId: '737258673931',
    projectId: 'motorbike-crash-detection',
    authDomain: 'motorbike-crash-detection.firebaseapp.com',
    storageBucket: 'motorbike-crash-detection.appspot.com',
    measurementId: 'G-W9HMLZP3TJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8Ar2aqL2aNiCJXoP9Bkj6yFohbbzBgUg',
    appId: '1:737258673931:android:4bed7b343ba4824d3d740e',
    messagingSenderId: '737258673931',
    projectId: 'motorbike-crash-detection',
    storageBucket: 'motorbike-crash-detection.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBf8nrAp0m3q7Yf-yzi0pzKkuVkMSLxwug',
    appId: '1:737258673931:ios:60705db30205ea893d740e',
    messagingSenderId: '737258673931',
    projectId: 'motorbike-crash-detection',
    storageBucket: 'motorbike-crash-detection.appspot.com',
    androidClientId: '737258673931-u4l3e6tjeehu78sr8acm7l46ar2mn3g5.apps.googleusercontent.com',
    iosClientId: '737258673931-t9bdj15hejlfi2svdrm6tj74iismdnbd.apps.googleusercontent.com',
    iosBundleId: 'com.example.motorbikeCrashDetection',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBf8nrAp0m3q7Yf-yzi0pzKkuVkMSLxwug',
    appId: '1:737258673931:ios:60705db30205ea893d740e',
    messagingSenderId: '737258673931',
    projectId: 'motorbike-crash-detection',
    storageBucket: 'motorbike-crash-detection.appspot.com',
    androidClientId: '737258673931-u4l3e6tjeehu78sr8acm7l46ar2mn3g5.apps.googleusercontent.com',
    iosClientId: '737258673931-t9bdj15hejlfi2svdrm6tj74iismdnbd.apps.googleusercontent.com',
    iosBundleId: 'com.example.motorbikeCrashDetection',
  );
}
