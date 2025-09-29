import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class InsightsByPriorityModel extends Equatable implements BaseModel {
  final int? critical;
  final int? high;
  final int? medium;
  final int? low;

  const InsightsByPriorityModel({
    this.critical,
    this.high,
    this.medium,
    this.low,
  });

  factory InsightsByPriorityModel.fromJson(Map<String, dynamic> json) {
    return InsightsByPriorityModel(
      critical: json['critical'] as int? ?? 0,
      high: json['high'] as int? ?? 0,
      medium: json['medium'] as int? ?? 0,
      low: json['low'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'critical': critical,
    'high': high,
    'medium': medium,
    'low': low,
  };

  @override
  List<Object?> get props => [critical, high, medium, low];
}
