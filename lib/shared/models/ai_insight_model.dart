import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/enums/insight_priority.dart';
import 'package:team_intelligence/shared/enums/insight_type.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class AIInsightModel extends Equatable implements BaseModel {
  final String id;
  final String projectId;
  final String message;
  final InsightType type;
  final InsightPriority priority;
  final DateTime createdAt;

  const AIInsightModel({
    required this.id,
    required this.projectId,
    required this.message,
    required this.type,
    required this.priority,
    required this.createdAt,
  });

  factory AIInsightModel.fromJson(Map<String, dynamic> json) {
    return AIInsightModel(
      id: json['id'] as String? ?? '',
      projectId: json['projectId'] as String? ?? '',
      message: json['message'] as String? ?? '',
      type: InsightType.values.firstWhere(
        (e) => e.name == (json['type'] as String? ?? 'workloadRedistribution'),
        orElse: () => InsightType.workloadRedistribution,
      ),
      priority: InsightPriority.values.firstWhere(
        (e) => e.name == (json['priority'] as String? ?? 'low'),
        orElse: () => InsightPriority.low,
      ),
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'message': message,
    'type': type.name,
    'priority': priority.name,
    'createdAt': createdAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    projectId,
    message,
    type,
    priority,
    createdAt,
  ];
}
