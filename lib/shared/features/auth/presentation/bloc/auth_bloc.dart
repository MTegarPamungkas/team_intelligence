import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/services/navigation_service.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/auth/domain/usecases/auth.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_event.dart';
import 'package:team_intelligence/shared/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Auth auth;
  final NavigationService navigationService =
      GetIt.instance<NavigationService>();
  final LocalStorage localStorage = GetIt.instance<LocalStorage>();

  AuthBloc(this.auth) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginAuth);
    on<RegisterEvent>(_onRegisterAuth);
    on<LogoutEvent>(_onLogoutAuth);
  }

  Future<void> _onLoginAuth(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await auth.login(event.email, event.password);
    dev.log('Login attempt for email: ${event.email}', name: 'AuthBloc');
    dev.log('Login result: $result', name: 'AuthBloc');
    result.fold(
      (failure) {
        emit(AuthError(failure.message));
        dev.log('Login failed: ${failure.message}', name: 'AuthBloc');
      },
      (entity) {
        emit(AuthLoaded(entity));
        localStorage.saveUser(entity.user);
        localStorage.setString('token', entity.token ?? '');
        navigationService.navigateAndClearStack('/');
        dev.log('User logged in: ${entity}', name: 'AuthBloc');
      },
    );
  }

  Future<void> _onRegisterAuth(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event.password != event.confirmPassword) {
      emit(AuthError('Passwords do not match'));
      return;
    }

    emit(AuthLoading());
    final result = await auth.register(event.name, event.email, event.password);
    dev.log('Registration attempt for email: ${event.email}', name: 'AuthBloc');
    dev.log('Registration result: $result', name: 'AuthBloc');
    result.fold(
      (failure) {
        emit(AuthError(failure.message));
        dev.log('Registration failed: ${failure.message}', name: 'AuthBloc');
      },
      (entity) {
        emit(AuthLoaded(entity));
        dev.log('User registered: ${entity.user}', name: 'AuthBloc');
      },
    );
  }

  Future<void> _onLogoutAuth(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    await localStorage.clear();
    localStorage.clearSelectedProject();
    navigationService.navigateAndClearStack('/login');
    dev.log('User logged out', name: 'AuthBloc');
  }
}
