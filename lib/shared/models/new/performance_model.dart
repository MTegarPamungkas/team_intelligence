import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class PerformanceModel extends Equatable implements BaseModel {
  final double? avgEfficiency;
  final int? totalFocusTime;
  final int? completionRate;

  const PerformanceModel({
    this.avgEfficiency,
    this.totalFocusTime,
    this.completionRate,
  });

  factory PerformanceModel.fromJson(Map<String, dynamic> json) {
    return PerformanceModel(
      avgEfficiency: (json['avgEfficiency'] as num?)?.toDouble() ?? 0.0,
      totalFocusTime: json['totalFocusTime'] as int? ?? 0,
      completionRate: json['completionRate'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'avgEfficiency': avgEfficiency,
    'totalFocusTime': totalFocusTime,
    'completionRate': completionRate,
  };

  @override
  List<Object?> get props => [avgEfficiency, totalFocusTime, completionRate];
}
