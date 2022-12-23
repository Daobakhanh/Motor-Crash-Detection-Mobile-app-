import 'package:motorbike_crash_detection/data/public/get_infor_env_file.dart';
import 'package:dio/dio.dart';
import 'package:motorbike_crash_detection/modules/app_state/repo/app_access_token_local_storage.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

class DioBase {
  static Future<Dio> dioWithBaseOption() async {
    String apiUrl = await getApiUrl() ?? '';
    return Dio(
      BaseOptions(baseUrl: apiUrl, connectTimeout: 3000),
    );
  }

  static Future<String> getAuthorization() async {
    String userAccessToken = await getAccessTokenFromLocalStorage() ?? '';
    String authorization = "Bearer $userAccessToken";
    DebugPrint.dataLog(title: "authorization", data: authorization);
    return authorization;
  }

  static Future<Response<dynamic>> get({
    required String endUrl,
  }) async {
    final dio = await dioWithBaseOption();
    final authorization = await getAuthorization();
    return dio.get(
      endUrl,
      options: Options(
        method: 'get',
        headers: {
          "Authorization": authorization,
          "Content-Type": "application/json"
        },
      ),
    );
  }

  static Future<Response<dynamic>> delete({
    required String endUrl,
  }) async {
    final dio = await dioWithBaseOption();
    final authorization = await getAuthorization();
    return dio.delete(
      endUrl,
      options: Options(
        method: 'delete',
        headers: {
          "Authorization": authorization,
          "Content-Type": "application/json"
        },
      ),
    );
  }

  static Future<Response<dynamic>> post({
    required String endUrl,
    required Map<String, dynamic> data,
  }) async {
    final dio = await dioWithBaseOption();
    final authorization = await getAuthorization();
    return dio.post(
      endUrl,
      data: data,
      options: Options(
        method: 'post',
        headers: {
          "Authorization": authorization,
          // "Content-Type": "application/json",
        },
      ),
    );
  }

  static Future<Response<dynamic>> put({
    required String endUrl,
    required Map<String, dynamic> data,
  }) async {
    final dio = await dioWithBaseOption();
    final authorization = await getAuthorization();
    return dio.put(
      endUrl,
      data: data,
      options: Options(
        method: 'put',
        headers: {
          "Authorization": authorization,
          "Content-Type": "application/json",
        },
      ),
    );
  }
}
