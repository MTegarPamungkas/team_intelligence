import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_intelligence/core/storage/cache_manager.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/core/storage/secure_storage.dart';

Future<void> configureStorageModule(GetIt sl) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerSingleton<LocalStorage>(LocalStorage(sl<SharedPreferences>()));
  sl.registerSingleton<CacheManager>(CacheManager());
  sl.registerSingleton<SecureStorage>(SecureStorage());
}
