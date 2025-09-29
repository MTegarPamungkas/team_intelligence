// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:team_intelligence/app/theme/locale_bloc.dart';
import 'package:team_intelligence/app/theme/theme_bloc.dart';
import 'package:team_intelligence/l10n/app_localizations.dart';
import 'package:team_intelligence/app/theme/app_theme.dart';
import 'package:team_intelligence/app/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()..add(LoadTheme())),
        BlocProvider(create: (context) => LocaleBloc()..add(LoadLocale())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp.router(
                title: 'Team Intelligence',

                // Theme
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,

                // Localization
                locale: localeState.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,

                localeResolutionCallback: (locale, supportedLocales) {
                  if (locale != null && supportedLocales.contains(locale)) {
                    return locale;
                  }
                  return const Locale('en');
                },

                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
