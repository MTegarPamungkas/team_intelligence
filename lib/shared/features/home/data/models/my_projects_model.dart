import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/my_projects_entity.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/project_model.dart';

class MyProjectsModel extends Equatable implements BaseModel {
  final String? message;
  final int totalProjects;
  final List<ProjectModel> projects;

  const MyProjectsModel({
    this.message,
    required this.totalProjects,
    required this.projects,
  });

  factory MyProjectsModel.fromJson(Map<String, dynamic> json) {
    return MyProjectsModel(
      message: json['message'],
      totalProjects: json['totalProjects'],
      projects: (json['projects'] as List)
          .map((project) => ProjectModel.fromJsonApi(project))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'message': message,
    'totalProjects': totalProjects,
    'projects': projects.map((project) => project.toJson()).toList(),
  };

  MyProjectsEntity toEntity() => MyProjectsEntity(
    message: message,
    totalProjects: totalProjects,
    projects: projects,
  );

  @override
  List<Object?> get props => [message, totalProjects, projects];
}
