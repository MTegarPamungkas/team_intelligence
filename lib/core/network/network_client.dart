import 'package:dio/dio.dart';
import 'package:team_intelligence/app/config/app_config.dart';
import 'package:team_intelligence/core/network/interceptors/auth_interceptor.dart';
import 'package:team_intelligence/core/network/interceptors/logging_interceptor.dart';
import 'package:team_intelligence/core/network/interceptors/retry_interceptor.dart';

class NetworkClient {
  final Dio dio;

  NetworkClient(this.dio) {
    dio.options.baseUrl = AppConfig.apiBaseUrl;
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(RetryInterceptor(dio: dio));
  }

  Future<Response> get(String path) async => await dio.get(path);
  Future<Response> post(String path, {dynamic data}) async =>
      await dio.post(path, data: data);
}
