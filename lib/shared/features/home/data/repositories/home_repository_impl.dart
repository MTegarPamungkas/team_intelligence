import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/error_handler.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/core/network/network_info.dart';
import 'package:team_intelligence/shared/features/home/data/datasources/home_local_datasource.dart';
import 'package:team_intelligence/shared/features/home/data/datasources/home_remote_datasource.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/home_entity.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/my_projects_entity.dart';
import 'package:team_intelligence/shared/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, HomeEntity>> getHome() async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getHome();
        await localDataSource.cacheHome(model);
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    } else {
      try {
        final model = await localDataSource.getHome();
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    }
  }

  @override
  Future<Either<Failure, MyProjectsEntity>> getMyProjects() async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getMyProjects();
        await localDataSource.cacheMyProjects(model);
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    } else {
      try {
        final model = await localDataSource.getMyProjects();
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    }
  }
}
