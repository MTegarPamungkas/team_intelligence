import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/error_handler.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/core/network/network_info.dart';
import 'package:team_intelligence/shared/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:team_intelligence/shared/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:team_intelligence/shared/features/auth/domain/entities/auth_entity.dart';
import 'package:team_intelligence/shared/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(
    String email,
    String password,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.login(email, password);
        await localDataSource.cacheAuth(model);
        return Right(model.toEntity());
      } catch (e) {
        dev.log('Login error: $e', name: 'AuthRepositoryImpl');
        return Left(ErrorHandler.handleException(e as Exception));
      }
    } else {
      try {
        final model = await localDataSource.getAuth();
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> register(
    String name,
    String email,
    String password,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.register(name, email, password);
        await localDataSource.cacheAuth(model);
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
