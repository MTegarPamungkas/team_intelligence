import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/enums/activity_type.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class ActivityModel extends Equatable implements BaseModel {
  final String id;
  final String userId;
  final String projectId;
  final String userName;
  final String action;
  final DateTime timestamp;
  final ActivityType type;

  const ActivityModel({
    required this.id,
    required this.userId,
    required this.projectId,
    required this.userName,
    required this.action,
    required this.timestamp,
    required this.type,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      projectId: json['projectId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      action: json['action'] as String? ?? '',
      timestamp:
          DateTime.tryParse(json['timestamp'] as String? ?? '') ??
          DateTime.now(),
      type: ActivityType.values.firstWhere(
        (e) => e.name == (json['type'] as String? ?? 'commit'),
        orElse: () => ActivityType.commit,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'projectId': projectId,
    'userName': userName,
    'action': action,
    'timestamp': timestamp.toIso8601String(),
    'type': type.name,
  };

  @override
  List<Object?> get props => [
    id,
    userId,
    projectId,
    userName,
    action,
    timestamp,
    type,
  ];
}
