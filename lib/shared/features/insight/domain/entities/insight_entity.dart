import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/insight/data/models/insight_model.dart';
import 'package:team_intelligence/shared/models/ai_insight_model.dart';

class InsightEntity extends Equatable {
  final String? message;
  final int? totalInsights;
  final InsightsPriority? insightsByPriority;
  final List<AIInsightModel>? insights;

  const InsightEntity({
    this.message,
    this.totalInsights,
    this.insightsByPriority,
    this.insights,
  });

  @override
  List<Object?> get props => [
    message,
    totalInsights,
    insightsByPriority,
    insights,
  ];
}
