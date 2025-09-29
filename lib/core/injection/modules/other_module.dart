import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/services/navigation_service.dart';

Future<void> configureOtherModule(GetIt sl) async {
  sl.registerSingleton<NavigationService>(NavigationService());
}
