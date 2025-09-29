import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/home_entity.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/my_projects_entity.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeEntity entity;

  HomeLoaded(this.entity);

  @override
  List<Object?> get props => [entity];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class HomeProjectsLoaded extends HomeState {
  final MyProjectsEntity myProjects;

  HomeProjectsLoaded(this.myProjects);

  @override
  List<Object?> get props => [myProjects];
}
