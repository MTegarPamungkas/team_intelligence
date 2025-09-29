import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/error_handler.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/core/network/network_info.dart';
import 'package:team_intelligence/shared/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:team_intelligence/shared/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SummaryEntity>> getDashboard(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await remoteDataSource.getDashboard(id);
        await localDataSource.cacheDashboard(model);
        return Right(model.toEntity());
      } catch (e) {
        dev.log('GetDashboard error: $e', name: 'DashboardRepositoryImpl');
        return Left(ErrorHandler.handleException(e as Exception));
      }
    } else {
      try {
        final model = await localDataSource.getDashboard();
        return Right(model.toEntity());
      } catch (e) {
        return Left(ErrorHandler.handleException(e as Exception));
      }
    }
  }
}
