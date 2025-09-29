import 'package:get_it/get_it.dart';
import 'package:team_intelligence/shared/features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'package:team_intelligence/shared/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:team_intelligence/shared/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/usecases/dashboard.dart';

Future<void> configureDashboardModule(GetIt sl) async {
  // Register Data Sources
  sl.registerSingleton<DashboardLocalDataSource>(
    DashboardLocalDataSourceImpl(sl()),
  );
  sl.registerSingleton<DashboardRemoteDataSource>(
    DashboardRemoteDataSourceImpl(sl()),
  );

  // Register Repository
  sl.registerSingleton<DashboardRepository>(
    DashboardRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Register Use Case
  sl.registerSingleton<Dashboard>(Dashboard(sl()));
}
