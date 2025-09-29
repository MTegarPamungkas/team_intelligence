import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/error_handler.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/core/network/network_info.dart';
import 'package:team_intelligence/shared/features/insight/data/datasources/insight_local_datasource.dart';
import 'package:team_intelligence/shared/features/insight/data/datasources/insight_remote_datasource.dart';
import 'package:team_intelligence/shared/features/insight/domain/entities/insight_entity.dart';
import 'package:team_intelligence/shared/features/insight/domain/repositories/insight_repository.dart';

class InsightRepositoryImpl implements InsightRepository {
  final InsightRemoteDataSource remoteDataSource;
  final InsightLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  InsightRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, InsightEntity>> getInsight(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getInsight(id);
        await localDataSource.cacheInsight(model);
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    } else {
      try {
        final model = await localDataSource.getInsight();
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    }
  }
}
