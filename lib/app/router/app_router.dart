import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:team_intelligence/app/router/routes.dart';
import 'package:team_intelligence/core/services/navigation_service.dart';
import 'package:team_intelligence/shared/features/activity/presentation/pages/activity_page.dart';
import 'package:team_intelligence/shared/features/auth/presentation/pages/auth_page.dart';
import 'package:team_intelligence/shared/features/auth/presentation/pages/login_page.dart';
import 'package:team_intelligence/shared/features/auth/presentation/pages/register_page.dart';
import 'package:team_intelligence/shared/features/home/presentation/pages/home_page.dart';
import 'package:team_intelligence/shared/features/insight/presentation/pages/insight_page.dart';
import 'package:team_intelligence/shared/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: GetIt.instance<NavigationService>().navigatorKey,
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: Routes.auth,
        name: 'auth',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: Routes.activity,
        name: 'activity',
        builder: (context, state) => const ActivityPage(),
      ),
      GoRoute(
        path: Routes.insights,
        name: 'insights',
        builder: (context, state) => const InsightPage(),
      ),
    ],
  );
}
