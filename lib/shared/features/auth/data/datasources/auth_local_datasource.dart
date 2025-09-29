import 'dart:convert';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/auth/data/models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<AuthModel> getAuth();
  Future<void> cacheAuth(AuthModel model);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage localStorage;

  AuthLocalDataSourceImpl(this.localStorage);

  @override
  Future<AuthModel> getAuth() async {
    final jsonString = localStorage.getString('auth');
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return AuthModel.fromJson(jsonMap);
    }
    throw CacheException();
  }

  @override
  Future<void> cacheAuth(AuthModel model) async {
    final jsonString = json.encode(model.toJson());
    await localStorage.setString('auth', jsonString);
  }
}
