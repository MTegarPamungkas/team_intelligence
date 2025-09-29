import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/activity_model.dart';

class ActivityEntity extends Equatable {
  final String? message;
  final int? totalActivities;
  final List<ActivityModel>? activities;

  const ActivityEntity({this.message, this.totalActivities, this.activities});

  @override
  List<Object?> get props => [message, activities];
}
