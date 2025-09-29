import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/services/navigation_service.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/splash/domain/entities/splash_entity.dart';
import 'package:team_intelligence/shared/features/splash/presentation/bloc/splash_event.dart';
import 'package:team_intelligence/shared/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final LocalStorage localStorage = GetIt.instance<LocalStorage>();
  final NavigationService navigationService =
      GetIt.instance<NavigationService>();

  SplashBloc() : super(SplashInitial()) {
    on<FetchSplash>(_onFetchSplash);
  }

  Future<void> _onFetchSplash(
    FetchSplash event,
    Emitter<SplashState> emit,
  ) async {
    print("🔄 Starting splash process...");
    emit(SplashLoading());

    try {
      await Future.delayed(const Duration(milliseconds: 2000));

      print("📱 Checking local storage for login status...");

      final isLoggedIn = _checkLoginStatus();
      final isFirstTime = _checkFirstTimeUser();

      print(
        "✅ Local check completed - isLoggedIn: $isLoggedIn, isFirstTime: $isFirstTime",
      );

      final splashEntity = SplashEntity.fromLocalData(
        isLoggedIn: isLoggedIn,
        isFirstTime: isFirstTime,
        userId: isLoggedIn ? localStorage.getUser()?.id : null,
        userName: isLoggedIn ? localStorage.getUser()?.name : null,
      );

      emit(SplashLoaded(splashEntity));

      await Future.delayed(const Duration(milliseconds: 300));

      // if (isFirstTime) {
      //   print("🚀 Navigating to onboarding (first time user)");
      //   navigationService.navigateAndClearStack('/onboarding');
      // } else
      if (isLoggedIn) {
        print("🚀 Navigating to home (logged in user)");
        navigationService.navigateAndClearStack('/');
      } else {
        print("🚀 Navigating to auth (need to login)");
        navigationService.navigateAndClearStack('/login');
      }
    } catch (e) {
      print("❌ Local storage error: $e");
      emit(SplashError('Failed to check login status'));

      await Future.delayed(const Duration(seconds: 1));
      navigationService.navigateAndClearStack('/auth');
    }
  }

  bool _checkLoginStatus() {
    try {
      // final token = localStorage.getString('auth_token');
      final userId = localStorage.getUser()?.id;

      // final hasValidToken = token != null && token.isNotEmpty;
      final hasValidUserId = userId != null && userId.isNotEmpty;

      return hasValidUserId;
      // return hasValidToken && hasValidUserId;
    } catch (e) {
      print("Error checking login status: $e");
      return false;
    }
  }

  bool _checkFirstTimeUser() {
    try {
      final hasSeenOnboarding = localStorage.getString('has_seen_onboarding');
      return hasSeenOnboarding == null || hasSeenOnboarding != 'true';
    } catch (e) {
      print("Error checking first time user: $e");
      return true;
    }
  }
}
