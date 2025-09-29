import 'package:flutter/widgets.dart';
import 'package:team_intelligence/l10n/app_localizations.dart';

extension AppLocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
