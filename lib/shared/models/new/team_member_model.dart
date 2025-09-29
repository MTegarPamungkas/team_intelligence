import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/permission_model.dart';

class TeamMemberModel extends Equatable implements BaseModel {
  final String? id;
  final String? projectId;
  final String? userId;
  final String? role;
  final String? projectRole;
  final String? status;
  final String? joinedAt;
  final PermissionsModel? permissions;
  final String? name;

  const TeamMemberModel({
    this.id,
    this.projectId,
    this.userId,
    this.role,
    this.projectRole,
    this.status,
    this.joinedAt,
    this.permissions,
    this.name,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: json['id'] as String? ?? '',
      projectId: json['projectId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      role: json['role'] as String? ?? '',
      projectRole: json['projectRole'] as String? ?? '',
      status: json['status'] as String? ?? '',
      joinedAt: json['joinedAt'] as String? ?? '',
      permissions: PermissionsModel.fromJson(json['permissions'] ?? {}),
      name: json['name'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'userId': userId,
    'role': role,
    'projectRole': projectRole,
    'status': status,
    'joinedAt': joinedAt,
    'permissions': permissions?.toJson(),
    'name': name,
  };

  @override
  List<Object?> get props => [
    id,
    projectId,
    userId,
    role,
    projectRole,
    status,
    joinedAt,
    permissions,
    name,
  ];
}
