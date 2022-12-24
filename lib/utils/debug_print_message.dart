import 'package:flutter/material.dart';

class DebugPrint {
  static void dataLog({
    required String currentFile,
    required String title,
    required dynamic data,
  }) {
    debugPrint(
      '##### $currentFile - $title : $data',
    );
  }

  static void authenLog(
      {required String title,
      required String currentFile,
      required String message,
      dynamic data}) {
    debugPrint(
      '##### AUTH STATUS AT $currentFile : $title is $message , data: $data',
    );
  }

  static void callApiLog(
      {required String currentFile,
      required String message,
      String? httpMethod,
      dynamic data,
      String? url}) {
    debugPrint(
      '##### CALL API AT $currentFile : $httpMethod $url - $message , data : $data',
    );
  }
}
