import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/member_status_model.dart';
import 'package:team_intelligence/shared/models/new/mood_distribution_model.dart';
import 'package:team_intelligence/shared/models/new/performance_model.dart';

class TeamMetricsModel extends Equatable implements BaseModel {
  final int? totalMembers;
  final MemberStatusModel? memberStatus;
  final PerformanceModel? performance;
  final MoodDistributionModel? moodDistribution;

  const TeamMetricsModel({
    this.totalMembers,
    this.memberStatus,
    this.performance,
    this.moodDistribution,
  });

  factory TeamMetricsModel.fromJson(Map<String, dynamic> json) {
    return TeamMetricsModel(
      totalMembers: json['totalMembers'] as int? ?? 0,
      memberStatus: MemberStatusModel.fromJson(json['memberStatus'] ?? {}),
      performance: PerformanceModel.fromJson(json['performance'] ?? {}),
      moodDistribution: MoodDistributionModel.fromJson(
        json['moodDistribution'] ?? {},
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'totalMembers': totalMembers,
    'memberStatus': memberStatus?.toJson(),
    'performance': performance?.toJson(),
    'moodDistribution': moodDistribution?.toJson(),
  };

  @override
  List<Object?> get props => [
    totalMembers,
    memberStatus,
    performance,
    moodDistribution,
  ];
}
