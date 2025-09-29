import 'package:get_it/get_it.dart';
import 'package:team_intelligence/shared/features/insight/data/datasources/insight_local_datasource.dart';
import 'package:team_intelligence/shared/features/insight/data/datasources/insight_remote_datasource.dart';
import 'package:team_intelligence/shared/features/insight/data/repositories/insight_repository_impl.dart';
import 'package:team_intelligence/shared/features/insight/domain/repositories/insight_repository.dart';
import 'package:team_intelligence/shared/features/insight/domain/usecases/insight.dart';

Future<void> configureInsightModule(GetIt sl) async {
  // Register Data Sources
  sl.registerSingleton<InsightLocalDataSource>(
    InsightLocalDataSourceImpl(sl()),
  );
  sl.registerSingleton<InsightRemoteDataSource>(
    InsightRemoteDataSourceImpl(sl()),
  );

  // Register Repository
  sl.registerSingleton<InsightRepository>(
    InsightRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Register Use Case
  sl.registerSingleton<Insight>(Insight(sl()));
}
