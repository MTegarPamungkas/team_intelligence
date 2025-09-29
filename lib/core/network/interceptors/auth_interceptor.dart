import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage localStorage = GetIt.instance<LocalStorage>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = await localStorage.getString('token') ?? '';
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException e, ErrorInterceptorHandler handler) {
    handler.next(e);
  }
}
