import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class ProjectModel extends Equatable implements BaseModel {
  final String? id;
  final String? name;
  final String? description;
  final String? status;
  final String? createdAt;
  final int? membersCount;
  final double? progress;

  const ProjectModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.membersCount,
    this.progress,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      membersCount: json['membersCount'] as int? ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  factory ProjectModel.fromJsonApi(Map<String, dynamic> json) {
    final projectData = json['project'];
    return ProjectModel(
      id: projectData['id'],
      name: projectData['name'],
      description: projectData['description'],
      status: projectData['status'],
      createdAt: projectData['createdAt'],
      membersCount: projectData['membersCount'],
      progress: (projectData['progress'] as num?)?.toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'status': status,
    'createdAt': createdAt,
    'membersCount': membersCount,
    'progress': progress,
  };

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    status,
    createdAt,
    membersCount,
    progress,
  ];

  ProjectModel toEntity() => ProjectModel(
    id: id,
    name: name,
    description: description,
    status: status,
    createdAt: createdAt,
    membersCount: membersCount,
    progress: progress,
  );
}
