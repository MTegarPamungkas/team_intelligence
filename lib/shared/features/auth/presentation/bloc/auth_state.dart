import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/auth/domain/entities/auth_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final AuthEntity entity;

  AuthLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}