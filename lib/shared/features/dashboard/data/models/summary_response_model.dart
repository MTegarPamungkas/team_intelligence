import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/project_model.dart';
import 'package:team_intelligence/shared/models/new/task_summary_model.dart';
import 'package:team_intelligence/shared/models/new/team_member_model.dart';
import 'package:team_intelligence/shared/models/new/team_metric_model.dart';

class SummaryResponseModel extends Equatable implements BaseModel {
  final String? message;
  final ProjectModel? project;
  final TeamMetricsModel? teamMetrics;
  final List<TeamMemberModel>? teamMembers;
  final TaskSummaryModel? taskSummary;

  const SummaryResponseModel({
    this.message,
    this.project,
    this.teamMetrics,
    this.teamMembers,
    this.taskSummary,
  });

  factory SummaryResponseModel.fromJson(Map<String, dynamic> json) {
    return SummaryResponseModel(
      message: json['message'],
      project: json['project'] != null
          ? ProjectModel.fromJson(json['project'] as Map<String, dynamic>)
          : null,
      teamMetrics: json['teamMetrics'] != null
          ? TeamMetricsModel.fromJson(
              json['teamMetrics'] as Map<String, dynamic>,
            )
          : null,
      teamMembers: json['teamMembers'] != null
          ? (json['teamMembers'] as List)
                .map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      taskSummary: json['taskSummary'] != null
          ? TaskSummaryModel.fromJson(
              json['taskSummary'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'message': message,
    'project': project?.toJson(),
    'teamMetrics': teamMetrics?.toJson(),
    'teamMembers': teamMembers?.map((e) => e.toJson()).toList(),
    'taskSummary': taskSummary?.toJson(),
  };

  SummaryEntity toEntity() => SummaryEntity(
    message: message,
    project: project?.toEntity(),
    teamMetrics: teamMetrics,
    teamMembers: teamMembers,
    taskSummary: taskSummary,
  );

  @override
  List<Object?> get props => [
    message,
    project,
    teamMetrics,
    teamMembers,
    taskSummary,
  ];
}
