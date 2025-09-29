import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/activity/domain/entities/activity_entity.dart';

abstract class ActivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final ActivityEntity entity;

  ActivityLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class ActivityError extends ActivityState {
  final String message;

  ActivityError(this.message);

  @override
  List<Object?> get props => [message];
}