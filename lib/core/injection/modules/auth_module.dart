import 'package:get_it/get_it.dart';
import 'package:team_intelligence/shared/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:team_intelligence/shared/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:team_intelligence/shared/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:team_intelligence/shared/features/auth/domain/repositories/auth_repository.dart';
import 'package:team_intelligence/shared/features/auth/domain/usecases/auth.dart';

Future<void> configureAuthModule(GetIt sl) async {
  // Register Data Sources
  sl.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(sl()),
  );
  sl.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(sl()),
  );

  // Register Repository
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Register Use Case
  sl.registerSingleton<Auth>(Auth(sl()));
}
