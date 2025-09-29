// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/app/theme/locale_bloc.dart';
import 'package:team_intelligence/app/theme/theme_bloc.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/auth/domain/usecases/auth.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_event.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_state.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:team_intelligence/shared/features/home/domain/usecases/home.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/home_bloc.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/home_event.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/home_state.dart';
import 'package:team_intelligence/shared/widgets/dialogs/error_dialog.dart';
import 'package:team_intelligence/shared/widgets/displays/modern_settings_item.dart';
import 'package:team_intelligence/shared/widgets/displays/theme_option.dart';
import 'package:team_intelligence/shared/widgets/shimmer/skeleton_list_tile.dart';

class BottomSheetHelper {
  static void showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurface.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    ModernSettingsItem(
                      icon: Icons.add_circle_outline,
                      title: 'Create a Project',
                      subtitle: 'Start something new',
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Create project'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    ModernSettingsItem(
                      icon: Icons.folder_outlined,
                      title: 'Select a Project',
                      subtitle: 'Switch workspace',
                      onTap: () {
                        Navigator.pop(context);
                        showProjectsBottomSheet(context);
                      },
                    ),

                    const SizedBox(height: 8),

                    ModernSettingsItem(
                      icon: Icons.person_outline,
                      title: 'Profile',
                      subtitle: 'Manage your account',
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Profile selected'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    ModernSettingsItem(
                      icon: Icons.palette_outlined,
                      title: 'Theme',
                      subtitle: 'Change app appearance',
                      onTap: () {
                        Navigator.pop(context);
                        _showThemeBottomSheet(context);
                      },
                    ),

                    const SizedBox(height: 8),

                    ModernSettingsItem(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: 'Select your language',
                      onTap: () {
                        Navigator.pop(context);
                        _showLanguageBottomSheet(context);
                      },
                    ),

                    const SizedBox(height: 16),
                    Divider(
                      color: context.colorScheme.onSurface.withOpacity(0.1),
                    ),
                    const SizedBox(height: 8),

                    ModernSettingsItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      subtitle: 'Sign out from your account',
                      isDestructive: true,
                      onTap: () {
                        Navigator.pop(context);
                        _showLogoutConfirmation(context);
                      },
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showProjectsBottomSheet(BuildContext context) {
    final LocalStorage localStorage = GetIt.instance<LocalStorage>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (innerContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  HomeBloc(GetIt.instance<Home>())
                    ..add(FetchMyProjectsHomeEvent()),
            ),
          ],
          child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeError) {
                showErrorDialog(context, state.message);
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Drag handle
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: context.colorScheme.onSurface.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.folder_outlined,
                                color: context.colorScheme.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Project',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: context.colorScheme.onSurface,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  Text(
                                    'Choose your workspace',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: context.colorScheme.onSurface
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _buildProjectsList(
                            context,
                            state,
                            localStorage,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  static Widget _buildProjectsList(
    BuildContext context,
    HomeState state,
    LocalStorage localStorage,
  ) {
    if (state is HomeProjectsLoaded && state.myProjects.projects.isNotEmpty) {
      return Column(
        children: state.myProjects.projects.map((project) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  localStorage.setSelectedProject(project);
                  Navigator.pop(context);

                  try {
                    final dashboardBloc = BlocProvider.of<DashboardBloc>(
                      context,
                      listen: false,
                    );
                    dashboardBloc.add(ProjectChanged(project.id ?? ''));
                  } catch (e) {
                    print(
                      'DashboardBloc not found in current context, relying on stream listener',
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.folder,
                          color: context.colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          project.name ?? 'Unnamed Project',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: context.colorScheme.onSurface.withOpacity(0.4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else if (state is HomeLoading) {
      return Column(
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SkeletonListTile.build(context),
          ),
        ),
      );
    } else if (state is HomeProjectsLoaded &&
        state.myProjects.projects.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(
                Icons.folder_off_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              Text(
                'No projects available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create a new project to get started',
                style: TextStyle(
                  fontSize: 14,
                  color: context.colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: context.colorScheme.error.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load projects',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  static void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (innerContext) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(GetIt.instance<Auth>())),
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              Navigator.pop(context);
              showErrorDialog(context, state.message);
            }
          },
          builder: (context, state) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.logout,
                    color: context.colorScheme.error,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Logout'),
              ],
            ),
            content: state is AuthLoading
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(child: Text('Logging out...')),
                    ],
                  )
                : const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(fontSize: 15),
                  ),
            actions: state is AuthLoading
                ? []
                : [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: context.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: context.colorScheme.error,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  static void _showThemeBottomSheet(BuildContext context) {
    final currentTheme = context.read<ThemeBloc>().state.themeMode;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurface.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.palette_outlined,
                            color: context.colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Theme',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurface,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              'Choose your preferred theme',
                              style: TextStyle(
                                fontSize: 14,
                                color: context.colorScheme.onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    ThemeOption(
                      context: context,
                      icon: Icons.brightness_auto,
                      title: 'System',
                      subtitle: 'Follow device settings',
                      isSelected: currentTheme == ThemeMode.system,
                      onTap: () {
                        context.read<ThemeBloc>().add(
                          ChangeTheme(ThemeMode.system),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Theme changed to System'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    ThemeOption(
                      context: context,
                      icon: Icons.light_mode,
                      title: 'Light',
                      subtitle: 'Bright and clear',
                      isSelected: currentTheme == ThemeMode.light,
                      onTap: () {
                        context.read<ThemeBloc>().add(
                          ChangeTheme(ThemeMode.light),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Theme changed to Light'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    ThemeOption(
                      context: context,
                      icon: Icons.dark_mode,
                      title: 'Dark',
                      subtitle: 'Easy on the eyes',
                      isSelected: currentTheme == ThemeMode.dark,
                      onTap: () {
                        context.read<ThemeBloc>().add(
                          ChangeTheme(ThemeMode.dark),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Theme changed to Dark'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void _showLanguageBottomSheet(BuildContext context) {
    final currentLanguage = context
        .read<LocaleBloc>()
        .state
        .locale
        .languageCode;

    final languages = [
      {
        'code': 'en',
        'name': 'English',
        'nativeName': 'English',
        'flag': '🇺🇸',
      },
      {
        'code': 'id',
        'name': 'Indonesian',
        'nativeName': 'Bahasa Indonesia',
        'flag': '🇮🇩',
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurface.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.language_outlined,
                        color: context.colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Language',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Choose your preferred language',
                            style: TextStyle(
                              fontSize: 14,
                              color: context.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    children: languages.map((language) {
                      final isSelected = currentLanguage == language['code'];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colorScheme.primaryContainer
                                      .withOpacity(0.5)
                                : context.colorScheme.surfaceVariant
                                      .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? context.colorScheme.primary
                                  : context.colorScheme.outline.withOpacity(
                                      0.1,
                                    ),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                context.read<LocaleBloc>().add(
                                  ChangeLocale(language['code']!),
                                );
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Language changed to ${language['name']}',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Text(
                                      language['flag']!,
                                      style: const TextStyle(fontSize: 32),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            language['name']!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  context.colorScheme.onSurface,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            language['nativeName']!,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: context
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color: context.colorScheme.primary,
                                        size: 24,
                                      )
                                    else
                                      Icon(
                                        Icons.circle_outlined,
                                        color: context.colorScheme.onSurface
                                            .withOpacity(0.3),
                                        size: 24,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
