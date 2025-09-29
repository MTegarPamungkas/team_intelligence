import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/insight/domain/entities/insight_entity.dart';

abstract class InsightState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InsightInitial extends InsightState {}

class InsightLoading extends InsightState {}

class InsightLoaded extends InsightState {
  final InsightEntity entity;

  InsightLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class InsightError extends InsightState {
  final String message;

  InsightError(this.message);

  @override
  List<Object?> get props => [message];
}