import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../lib.dart';

Future<String?> getApiUrl() async {
  await dotenv.load(fileName: ".env");
  String? apiUrl = dotenv.env['API'];
  return apiUrl;
}

Future<String?> getSocketUrl() async {
  await dotenv.load(fileName: ".env");
  String? apiUrl = dotenv.env['SOCKETAPI'];
  DebugPrint.dataLog(
      currentFile: 'get_infor_env',
      title: 'socketAPI from env file',
      data: apiUrl);
  return apiUrl;
}
