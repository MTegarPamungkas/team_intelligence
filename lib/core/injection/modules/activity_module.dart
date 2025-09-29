import 'package:get_it/get_it.dart';
import 'package:team_intelligence/shared/features/activity/data/datasources/activity_local_datasource.dart';
import 'package:team_intelligence/shared/features/activity/data/datasources/activity_remote_datasource.dart';
import 'package:team_intelligence/shared/features/activity/data/repositories/activity_repository_impl.dart';
import 'package:team_intelligence/shared/features/activity/domain/repositories/activity_repository.dart';
import 'package:team_intelligence/shared/features/activity/domain/usecases/activity.dart';

Future<void> configureActivityModule(GetIt sl) async {
  // Register Data Sources
  sl.registerSingleton<ActivityLocalDataSource>(
    ActivityLocalDataSourceImpl(sl()),
  );
  sl.registerSingleton<ActivityRemoteDataSource>(
    ActivityRemoteDataSourceImpl(sl()),
  );

  // Register Repository
  sl.registerSingleton<ActivityRepository>(
    ActivityRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Register Use Case
  sl.registerSingleton<Activity>(Activity(sl()));
}
