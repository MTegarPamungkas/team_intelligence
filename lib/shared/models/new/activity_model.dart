import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/ai_insight_metadata_model.dart';
import 'package:team_intelligence/shared/models/new/commit_metadata_model.dart';
import 'package:team_intelligence/shared/models/new/meeting_metadata_model.dart';
import 'package:team_intelligence/shared/models/new/progress_update_metadata_model%20copy.dart';
import 'package:team_intelligence/shared/models/new/status_update_metadata_model.dart';

class ActivityModel extends Equatable implements BaseModel {
  final String id;
  final String projectId;
  final String userId;
  final String? taskId;
  final String type;
  final String action;
  final String description;
  final String visibility;
  final Map<String, dynamic> metadata;
  final String timestamp;

  const ActivityModel({
    required this.id,
    required this.projectId,
    required this.userId,
    this.taskId,
    required this.type,
    required this.action,
    required this.description,
    required this.visibility,
    required this.metadata,
    required this.timestamp,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'] as Map<String, dynamic>? ?? {};
    return ActivityModel(
      id: json['id'] as String? ?? '',
      projectId: json['projectId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      taskId: json['taskId'] as String?,
      type: json['type'] as String? ?? '',
      action: json['action'] as String? ?? '',
      description: json['description'] as String? ?? '',
      visibility: json['visibility'] as String? ?? '',
      metadata: metadata,
      timestamp: json['timestamp'] as String? ?? '',
    );
  }

  dynamic getParsedMetadata() {
    switch (type) {
      case 'meeting_scheduled':
        return MeetingMetadataModel.fromJson(metadata);
      case 'status_update':
        return StatusUpdateMetadataModel.fromJson(metadata);
      case 'ai_insight_generated':
        return AiInsightMetadataModel.fromJson(metadata);
      case 'progress_update':
        return ProgressUpdateMetadataModel.fromJson(metadata);
      case 'commit':
        return CommitMetadataModel.fromJson(metadata);
      case 'task_assigned':
      case 'focus_started':
      case 'task_completed':
        return metadata;
      default:
        return metadata;
    }
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'userId': userId,
    'taskId': taskId,
    'type': type,
    'action': action,
    'description': description,
    'visibility': visibility,
    'metadata': metadata,
    'timestamp': timestamp,
  };

  @override
  List<Object?> get props => [
    id,
    projectId,
    userId,
    taskId,
    type,
    action,
    description,
    visibility,
    metadata,
    timestamp,
  ];
}
