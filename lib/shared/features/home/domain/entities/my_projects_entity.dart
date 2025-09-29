import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/project_model.dart';

class MyProjectsEntity extends Equatable {
  final String? message;
  final int totalProjects;
  final List<ProjectModel> projects;

  const MyProjectsEntity({
    this.message,
    required this.totalProjects,
    required this.projects,
  });

  @override
  List<Object?> get props => [message, totalProjects, projects];
}
