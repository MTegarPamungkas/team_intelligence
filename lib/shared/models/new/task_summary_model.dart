import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class TaskSummaryModel extends Equatable implements BaseModel {
  final int? totalTasks;
  final int? completedTasks;
  final int? completionRate;

  const TaskSummaryModel({
    this.totalTasks,
    this.completedTasks,
    this.completionRate,
  });

  factory TaskSummaryModel.fromJson(Map<String, dynamic> json) {
    return TaskSummaryModel(
      totalTasks: json['totalTasks'] as int? ?? 0,
      completedTasks: json['completedTasks'] as int? ?? 0,
      completionRate: json['completionRate'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'totalTasks': totalTasks,
    'completedTasks': completedTasks,
    'completionRate': completionRate,
  };

  @override
  List<Object?> get props => [totalTasks, completedTasks, completionRate];
}
