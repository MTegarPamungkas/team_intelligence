import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/splash/domain/entities/splash_entity.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  final SplashEntity entity;

  SplashLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class SplashError extends SplashState {
  final String message;

  SplashError(this.message);

  @override
  List<Object?> get props => [message];
}