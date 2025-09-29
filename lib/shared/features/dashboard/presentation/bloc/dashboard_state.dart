import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final SummaryEntity entity;

  DashboardLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}

class DashboardRefreshing extends DashboardState {
  final SummaryEntity? previousData;

  DashboardRefreshing(this.previousData);

  @override
  List<Object?> get props => [previousData];
}
