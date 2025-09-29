import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class DataPointsModel extends Equatable implements BaseModel {
  final int? tasksAnalyzed;
  final int? membersAnalyzed;
  final int? activitiesAnalyzed;

  const DataPointsModel({
    this.tasksAnalyzed,
    this.membersAnalyzed,
    this.activitiesAnalyzed,
  });

  factory DataPointsModel.fromJson(Map<String, dynamic> json) {
    return DataPointsModel(
      tasksAnalyzed: json['tasksAnalyzed'] as int? ?? 0,
      membersAnalyzed: json['membersAnalyzed'] as int? ?? 0,
      activitiesAnalyzed: json['activitiesAnalyzed'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'tasksAnalyzed': tasksAnalyzed,
    'membersAnalyzed': membersAnalyzed,
    'activitiesAnalyzed': activitiesAnalyzed,
  };

  @override
  List<Object?> get props => [
    tasksAnalyzed,
    membersAnalyzed,
    activitiesAnalyzed,
  ];
}
