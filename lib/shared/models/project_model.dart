import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class ProjectModel extends Equatable implements BaseModel {
  final String? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? status;

  const ProjectModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.status,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      status: json['status'] as String? ?? '',
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
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'createdAt': createdAt,
    'status': status,
  };

  @override
  List<Object?> get props => [id, name, description, createdAt, status];

  ProjectModel toEntity() => ProjectModel(
    id: id,
    name: name,
    description: description,
    createdAt: createdAt,
    status: status,
  );
}
