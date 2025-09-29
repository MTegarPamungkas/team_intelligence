import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/network/network_client.dart';
import 'package:team_intelligence/core/network/network_info.dart';

Future<void> configureNetworkModule(GetIt sl) async {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<NetworkClient>(NetworkClient(sl<Dio>()));
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl(sl()));
}
