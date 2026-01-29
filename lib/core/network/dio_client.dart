import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://flutter.tharadtech.com/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dio.post(url, queryParameters: query, data: data);
  }
}
