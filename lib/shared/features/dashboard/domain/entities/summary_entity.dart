import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/new/project_model.dart';
import 'package:team_intelligence/shared/models/new/task_summary_model.dart';
import 'package:team_intelligence/shared/models/new/team_member_model.dart';
import 'package:team_intelligence/shared/models/new/team_metric_model.dart';

class SummaryEntity extends Equatable {
  final String? message;
  final ProjectModel? project;
  final TeamMetricsModel? teamMetrics;
  final List<TeamMemberModel>? teamMembers;
  final TaskSummaryModel? taskSummary;

  const SummaryEntity({
    this.message,
    this.project,
    this.teamMetrics,
    this.teamMembers,
    this.taskSummary,
  });

  @override
  List<Object?> get props => [
    message,
    project,
    teamMetrics,
    teamMembers,
    taskSummary,
  ];
}
