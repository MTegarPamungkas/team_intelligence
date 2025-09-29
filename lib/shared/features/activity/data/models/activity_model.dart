import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/activity/domain/entities/activity_entity.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/activity_model.dart';

class ActivityResponseModel extends Equatable implements BaseModel {
  final String? message;
  final int? totalActivities;
  final List<ActivityModel>? activities;

  const ActivityResponseModel({
    this.message,
    this.totalActivities,
    this.activities,
  });

  factory ActivityResponseModel.fromJson(Map<String, dynamic> json) {
    return ActivityResponseModel(
      message: json['message'] as String?,
      totalActivities: json['totalActivities'] as int?,
      activities: json['activities'] != null
          ? BaseModel.fromJsonList<ActivityModel>(
              json['activities'] as List<dynamic>,
              (activityJson) => ActivityModel.fromJson(activityJson),
            )
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'message': message,
    'totalActivities': totalActivities,
    'activities': activities?.map((activity) => activity.toJson()).toList(),
  };

  ActivityEntity toEntity() => ActivityEntity(
    message: message,
    totalActivities: totalActivities,
    activities: activities,
  );

  @override
  List<Object?> get props => [message, totalActivities, activities];
}
