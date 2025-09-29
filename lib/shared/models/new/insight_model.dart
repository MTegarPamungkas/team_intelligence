import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/insight_metadata_model.dart';

class InsightModel extends Equatable implements BaseModel {
  final String? id;
  final String? title;
  final String? type;
  final String? priority;
  final String? description;
  final String? recommendation;
  final List<int>? affectedUserIds;
  final String? estimatedImpact;
  final String? category;
  final String? projectId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? source;
  final double? confidence;
  final InsightMetadataModel? metadata;

  const InsightModel({
    this.id,
    this.title,
    this.type,
    this.priority,
    this.description,
    this.recommendation,
    this.affectedUserIds,
    this.estimatedImpact,
    this.category,
    this.projectId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.source,
    this.confidence,
    this.metadata,
  });

  factory InsightModel.fromJson(Map<String, dynamic> json) {
    return InsightModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? '',
      priority: json['priority'] as String? ?? '',
      description: json['description'] as String? ?? '',
      recommendation: json['recommendation'] as String? ?? '',
      affectedUserIds:
          (json['affectedUserIds'] as List<dynamic>?)?.cast<int>() ?? [],
      estimatedImpact: json['estimatedImpact'] as String? ?? '',
      category: json['category'] as String? ?? '',
      projectId: json['projectId'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      source: json['source'] as String? ?? '',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      metadata: InsightMetadataModel.fromJson(json['metadata'] ?? {}),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'type': type,
    'priority': priority,
    'description': description,
    'recommendation': recommendation,
    'affectedUserIds': affectedUserIds,
    'estimatedImpact': estimatedImpact,
    'category': category,
    'projectId': projectId,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'source': source,
    'confidence': confidence,
    'metadata': metadata?.toJson(),
  };

  @override
  List<Object?> get props => [
    id,
    title,
    type,
    priority,
    description,
    recommendation,
    affectedUserIds,
    estimatedImpact,
    category,
    projectId,
    status,
    createdAt,
    updatedAt,
    source,
    confidence,
    metadata,
  ];
}
