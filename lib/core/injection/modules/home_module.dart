import 'package:get_it/get_it.dart';
import 'package:team_intelligence/shared/features/home/data/datasources/home_local_datasource.dart';
import 'package:team_intelligence/shared/features/home/data/datasources/home_remote_datasource.dart';
import 'package:team_intelligence/shared/features/home/data/repositories/home_repository_impl.dart';
import 'package:team_intelligence/shared/features/home/domain/repositories/home_repository.dart';
import 'package:team_intelligence/shared/features/home/domain/usecases/home.dart';

Future<void> configureHomeModule(GetIt sl) async {
  // Register Data Sources
  sl.registerSingleton<HomeLocalDataSource>(
    HomeLocalDataSourceImpl(sl()),
  );
  sl.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(sl()),
  );

  // Register Repository
  sl.registerSingleton<HomeRepository>(
    HomeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Register Use Case
  sl.registerSingleton<Home>(Home(sl()));
}
