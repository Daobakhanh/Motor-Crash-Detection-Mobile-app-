import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

Future<String?> getApiUrl() async {
  await dotenv.load(fileName: ".env");
  String? apiUrl = dotenv.env['API'];
  DebugPrint.dataLog(
      currentFile: 'get_infor_env',
      title: 'ApiUrl from env file',
      data: apiUrl);
  return apiUrl;
}
