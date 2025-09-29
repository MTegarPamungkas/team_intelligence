// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SYNC';

  @override
  String get welcome => 'Welcome to !';

  @override
  String get appTagline => 'Team Intelligence Platform';

  @override
  String get welcomeLogin => 'Welcome Back';

  @override
  String get tagLineLogin => 'Sign in to continue to SYNC';

  @override
  String get welcomeRegister => 'Create Account';

  @override
  String get tagLineRegister => 'Join SYNC to collaborate smarter';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get name => 'Name';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get haveAccount => 'Already have an account? ';
}
