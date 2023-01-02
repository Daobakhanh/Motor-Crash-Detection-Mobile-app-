import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:motorbike_crash_detection/data/public/get_infor_env_file.dart';
import 'package:dio/dio.dart';
import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

import '../modules/app_state/repo/app_access_token_local_storage_repo.dart';
import '../modules/auth/repo/auth_local_storage_repo.dart';

class DioBase {
  static Future<Dio> dioWithBaseOption() async {
    String apiUrl = await getApiUrl() ?? '';
    return Dio(
      BaseOptions(baseUrl: apiUrl, connectTimeout: 3000),
    );
  }

  static Future<String> getAuthorization() async {
    String backendUserAccessToken = await AuthLocalStorageRepo
            .getBackendUserAccesskenFromLocalStorage() ??
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiZlVaS3RHcWZ4UmI3Zmt3SXRodzJEYVA0ZU9mMSIsInBob25lTnVtYmVyIjoiMDM1NzY5ODU3MCIsImFkZHJlc3MiOiIxOSBuZ28gMTUgVGEgUXVhbmcgQnV1IiwiYXZhdGFyVXJsIjpudWxsLCJjaXRpemVuTnVtYmVyIjoiMDMwMjAwMDA1ODIxIiwibmFtZSI6IkRhbyBCYSBLaGFuaCIsImRhdGVPZkJpcnRoIjoiMy85LzIwMDAiLCJzb3NOdW1iZXJzIjpbXSwiZmNtVG9rZW5zIjpbImZUUWVRRlpCU2xTSXhTMXJZaXFHb206QVBBOTFiRlROU2xaWl9SczlZV0RPQ0xlRF96M2NEd0FzU3d3RWtLVFE5MG9BaGZCRGJobXBvbnlKZ29pWnlqVF8xY0NyYXpmUTU4dERHZjdodGpJdGluVGJEclMxRVdORVI4MWNydDFnVXFEaWpaQndjNWt3Y05LUVM2NDlNQ1JOcUZrMzhHV0xYN3MiXSwibGFzdFNpZ25JbkF0IjoiMjAyMi0xMi0yNVQwNjozNjoxMC43MTFaIn0sImlhdCI6MTY3MTk1MDE3MCwiZXhwIjoxNjc0NTQyMTcwfQ.UyKibh5LaR8ClX4tBxd9YtIxVstNHwqzcIjaEQvQZnM';

    String authorization = "Bearer $backendUserAccessToken";
    DebugPrint.dataLog(
        currentFile: "Diobase", title: "authorization", data: authorization);
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

class DioBaseAuth {
  static Future<Dio> dioWithBaseOption() async {
    String apiUrl = await getApiUrl() ?? '';
    return Dio(
      BaseOptions(baseUrl: apiUrl, connectTimeout: 3000),
    );
  }

  static Future<String> getAuthorization() async {
    String firebaseUserAccessToken =
        await getFbUserAccessTokenFromLocalStorage() ?? '';

    //FIXME: change code below when OTP ok
    String authorization = "Bearer $firebaseUserAccessToken";

    DebugPrint.dataLog(
        currentFile: "DioBaseAuth",
        title: "authorization",
        data: authorization);
    return authorization;
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
          "Content-Type": "application/json",
        },
      ),
    );
  }
}

class Api {
  final Dio api = Dio();
  String? accessToken;

  final _storage = const FlutterSecureStorage();

  Api() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = 'http://192.168.0.20:8080' + options.path;
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if ((error.response?.statusCode == 401 &&
          error.response?.data['message'] == "Invalid JWT")) {
        if (await _storage.containsKey(key: 'refreshToken')) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final response =
        await api.post('/auth/refresh', data: {'refreshToken': refreshToken});

    if (response.statusCode == 201) {
      accessToken = response.data;
      return true;
    } else {
      // refresh token is wrong
      accessToken = null;
      _storage.deleteAll();
      return false;
    }
  }
}
