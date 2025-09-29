import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

enum TeamMemberStatus { focused, available, blocked, offline }

class TeamMemberModel extends Equatable implements BaseModel {
  final String id;
  final String userId;
  final String role;
  final String name;
  final String projectId;
  final String avatar;
  final TeamMemberStatus status;
  final String currentTask;
  final double progress;
  final int focusDuration;
  final String mood;
  final double efficiency;
  final String joinedAt;

  const TeamMemberModel({
    required this.id,
    required this.userId,
    required this.role,
    required this.name,
    required this.projectId,
    required this.avatar,
    required this.status,
    required this.currentTask,
    required this.progress,
    required this.focusDuration,
    required this.mood,
    required this.efficiency,
    required this.joinedAt,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      role: json['role'] as String? ?? 'member',
      name: json['name'] as String? ?? '',
      projectId: json['projectId'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      status: TeamMemberStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String? ?? 'offline'),
        orElse: () => TeamMemberStatus.offline,
      ),
      currentTask: json['currentTask'] as String? ?? '',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      focusDuration: json['focusDuration'] as int? ?? 0,
      mood: json['mood'] as String? ?? '',
      efficiency: (json['efficiency'] as num?)?.toDouble() ?? 0.0,
      joinedAt: json['joinedAt'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'role': role,
    'name': name,
    'projectId': projectId,
    'avatar': avatar,
    'status': status.name,
    'currentTask': currentTask,
    'progress': progress,
    'focusDuration': focusDuration,
    'mood': mood,
    'efficiency': efficiency,
    'joinedAt': joinedAt,
  };

  @override
  List<Object?> get props => [
    id,
    userId,
    role,
    name,
    projectId,
    avatar,
    status,
    currentTask,
    progress,
    focusDuration,
    mood,
    efficiency,
    joinedAt,
  ];
}
