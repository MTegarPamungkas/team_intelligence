import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class ContextUsedModel extends Equatable implements BaseModel {
  final int? tasksCount;
  final int? activitiesCount;
  final int? insightsCount;
  final int? membersCount;
  final List<dynamic>? activities;
  final List<dynamic>? tasks;
  final List<dynamic>? insights;

  const ContextUsedModel({
    this.tasksCount,
    this.activitiesCount,
    this.insightsCount,
    this.membersCount,
    this.activities,
    this.tasks,
    this.insights,
  });

  factory ContextUsedModel.fromJson(Map<String, dynamic> json) {
    return ContextUsedModel(
      tasksCount: json['tasksCount'] as int?,
      activitiesCount: json['activitiesCount'] as int?,
      insightsCount: json['insightsCount'] as int?,
      membersCount: json['membersCount'] as int?,
      activities: json['activities'] as List<dynamic>?,
      tasks: json['tasks'] as List<dynamic>?,
      insights: json['insights'] as List<dynamic>?,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    if (tasksCount != null) 'tasksCount': tasksCount,
    if (activitiesCount != null) 'activitiesCount': activitiesCount,
    if (insightsCount != null) 'insightsCount': insightsCount,
    if (membersCount != null) 'membersCount': membersCount,
    if (activities != null) 'activities': activities,
    if (tasks != null) 'tasks': tasks,
    if (insights != null) 'insights': insights,
  };

  @override
  List<Object?> get props => [
    tasksCount,
    activitiesCount,
    insightsCount,
    membersCount,
    activities,
    tasks,
    insights,
  ];
}
