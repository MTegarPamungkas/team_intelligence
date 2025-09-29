import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/insight/domain/entities/insight_entity.dart';
import 'package:team_intelligence/shared/models/ai_insight_model.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class InsightResponseModel extends Equatable implements BaseModel {
  final String? message;
  final int? totalInsights;
  final InsightsPriority? insightsByPriority;
  final List<AIInsightModel>? insights;

  const InsightResponseModel({
    this.message,
    this.totalInsights,
    this.insightsByPriority,
    this.insights,
  });

  factory InsightResponseModel.fromJson(Map<String, dynamic> json) {
    return InsightResponseModel(
      message: json['message'] as String?,
      totalInsights: json['totalInsights'] as int?,
      insightsByPriority: json['insightsByPriority'] != null
          ? InsightsPriority.fromJson(
              json['insightsByPriority'] as Map<String, dynamic>,
            )
          : null,
      insights: json['insights'] != null
          ? (json['insights'] as List)
                .map((e) => AIInsightModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'message': message,
    'totalInsights': totalInsights,
    'insightsByPriority': insightsByPriority != null
        ? {
            'critical': insightsByPriority!.critical,
            'low': insightsByPriority!.low,
            'medium': insightsByPriority!.medium,
            'high': insightsByPriority!.high,
          }
        : null,
    'insights': insights?.map((e) => e.toJson()).toList(),
  };

  InsightEntity toEntity() => InsightEntity(
    message: message,
    totalInsights: totalInsights,
    insightsByPriority: insightsByPriority,
    insights: insights,
  );

  @override
  List<Object?> get props => [
    message,
    totalInsights,
    insightsByPriority,
    insights,
  ];
}

class InsightsPriority extends Equatable {
  final int critical;
  final int low;
  final int medium;
  final int high;

  const InsightsPriority({
    required this.critical,
    required this.low,
    required this.medium,
    required this.high,
  });

  factory InsightsPriority.fromJson(Map<String, dynamic> json) {
    return InsightsPriority(
      critical: json['critical'] as int? ?? 0,
      low: json['low'] as int? ?? 0,
      medium: json['medium'] as int? ?? 0,
      high: json['high'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [critical, low, medium, high];
}
