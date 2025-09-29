import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/injection/modules/activity_module.dart';
import 'package:team_intelligence/core/injection/modules/auth_module.dart';
import 'package:team_intelligence/core/injection/modules/dashboard_module.dart';
import 'package:team_intelligence/core/injection/modules/home_module.dart';
import 'package:team_intelligence/core/injection/modules/insight_module.dart';
import 'package:team_intelligence/core/injection/modules/network_module.dart';
import 'package:team_intelligence/core/injection/modules/other_module.dart';
import 'package:team_intelligence/core/injection/modules/storage_module.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  await configureStorageModule(sl);
  await configureNetworkModule(sl);
  await configureHomeModule(sl);
  await configureOtherModule(sl);
  await configureDashboardModule(sl);
  await configureAuthModule(sl);
  await configureActivityModule(sl);
  configureInsightModule(sl);
}
