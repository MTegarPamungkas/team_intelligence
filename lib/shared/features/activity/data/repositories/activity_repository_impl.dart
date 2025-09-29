import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/error_handler.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/core/network/network_info.dart';
import 'package:team_intelligence/shared/features/activity/data/datasources/activity_local_datasource.dart';
import 'package:team_intelligence/shared/features/activity/data/datasources/activity_remote_datasource.dart';
import 'package:team_intelligence/shared/features/activity/domain/entities/activity_entity.dart';
import 'package:team_intelligence/shared/features/activity/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;
  final ActivityLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ActivityRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ActivityEntity>> getActivity(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getActivity(id);
        await localDataSource.cacheActivity(model);
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    } else {
      try {
        final model = await localDataSource.getActivity();
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    }
  }
}
