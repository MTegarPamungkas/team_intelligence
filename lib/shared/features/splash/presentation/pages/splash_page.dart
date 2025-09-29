import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_intelligence/app/theme/color_scheme.dart';
import 'package:team_intelligence/app/theme/text_theme.dart';
import 'package:team_intelligence/l10n/l10n_extensions.dart';
import 'package:team_intelligence/shared/constants/asset_paths.dart';
import 'package:team_intelligence/shared/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:team_intelligence/shared/features/splash/presentation/bloc/splash_event.dart';
import 'package:team_intelligence/shared/features/splash/presentation/bloc/splash_state.dart';
import 'package:team_intelligence/shared/widgets/layouts/scaffold_wrapper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ScaffoldWrapper(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SplashBloc>(
            create: (context) => SplashBloc()..add(FetchSplash()),
          ),
        ],
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.surfaceContainer,
                  colorScheme.surfaceContainer,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: colorScheme.onSurface.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            AssetPaths.logo,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),

                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'SYNC',
                        style: AppTextTheme.withColor(
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                          AppColorScheme.lightBackground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.l10n.appTagline,
                        style: AppTextTheme.withColor(
                          AppTextTheme.appBarTitle,
                          AppColorScheme.lightBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
