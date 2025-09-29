import 'package:flutter/material.dart';
import 'package:team_intelligence/app/config/app_config.dart';
import 'package:team_intelligence/core/injection/injection_container.dart';
import 'package:team_intelligence/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialize();
  await configureDependencies();
  runApp(const App());
}
