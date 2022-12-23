import 'package:flutter/material.dart';

class DebugPrint {
  static void dataLog({
    required String title,
    required dynamic data,
  }) {
    debugPrint(
      '##### $title : $data',
    );
  }

  static void authenLog({required String message}) {
    debugPrint(
      '##### AUTH STATUS LOG : $message',
    );
  }

  static void callApiLog(
      {required String message,
      required String httpMethod,
      required String url}) {
    debugPrint(
      '##### DIO STATUS LOG : $httpMethod $url - $message',
    );
  }
}
