import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:team_intelligence/app/config/constants.dart';

class AppConfig {
  static String environment = 'development';
  static String apiBaseUrl = '';
  static bool analyticsEnabled = false;

  static Future<void> initialize() async {
    final configFile = AppConstants.isProduction
        ? 'assets/config/prod.json'
        : AppConstants.isStaging
        ? 'assets/config/staging.json'
        : 'assets/config/dev.json';

    final configString = await rootBundle.loadString(configFile);
    final config = json.decode(configString) as Map<String, dynamic>;

    environment = config['environment'] as String;
    apiBaseUrl = config['api_base_url'] as String;
    analyticsEnabled = config['analytics_enabled'] as bool;
  }
}
