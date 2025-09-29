import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/network/network_client.dart';
import 'package:team_intelligence/shared/constants/api_endpoints.dart';
import 'package:team_intelligence/shared/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkClient networkClient;

  AuthRemoteDataSourceImpl(this.networkClient);

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await networkClient.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      dev.log('Login Response: ${response.data}');
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      dev.log('DioException: ${e.response?.data}');
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<AuthModel> register(String name, String email, String password) async {
    try {
      final response = await networkClient.post(
        ApiEndpoints.register,
        data: {'name': name, 'email': email, 'password': password},
      );
      dev.log('Register Response: ${response.data}');
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      dev.log('DioException: ${e.response?.data}');
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    }
  }
}
