import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/permission_model.dart';

class MyRoleModel extends Equatable implements BaseModel {
  final String? membershipId;
  final String? projectRole;
  final String? status;
  final String? currentTaskId;
  final String? mood;
  final int? focusDuration;
  final int? efficiency;
  final String? joinedAt;
  final PermissionsModel? permissions;

  const MyRoleModel({
    this.membershipId,
    this.projectRole,
    this.status,
    this.currentTaskId,
    this.mood,
    this.focusDuration,
    this.efficiency,
    this.joinedAt,
    this.permissions,
  });

  factory MyRoleModel.fromJson(Map<String, dynamic> json) {
    return MyRoleModel(
      membershipId: json['membershipId'] as String? ?? '',
      projectRole: json['projectRole'] as String? ?? '',
      status: json['status'] as String? ?? '',
      currentTaskId: json['currentTaskId'] as String? ?? '',
      mood: json['mood'] as String? ?? '',
      focusDuration: json['focusDuration'] as int? ?? 0,
      efficiency: json['efficiency'] as int? ?? 0,
      joinedAt: json['joinedAt'] as String? ?? '',
      permissions: json['permissions'] != null
          ? PermissionsModel.fromJson(json['permissions'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'membershipId': membershipId,
    'projectRole': projectRole,
    'status': status,
    'currentTaskId': currentTaskId,
    'mood': mood,
    'focusDuration': focusDuration,
    'efficiency': efficiency,
    'joinedAt': joinedAt,
    'permissions': permissions?.toJson(),
  };

  @override
  List<Object?> get props => [
    membershipId,
    projectRole,
    status,
    currentTaskId,
    mood,
    focusDuration,
    efficiency,
    joinedAt,
    permissions,
  ];
}
