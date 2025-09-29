import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/data_points_model.dart';

class InsightMetadataModel extends Equatable implements BaseModel {
  final String? analysisDate;
  final DataPointsModel? dataPoints;

  const InsightMetadataModel({this.analysisDate, this.dataPoints});

  factory InsightMetadataModel.fromJson(Map<String, dynamic> json) {
    return InsightMetadataModel(
      analysisDate: json['analysisDate'] as String? ?? '',
      dataPoints: DataPointsModel.fromJson(json['dataPoints'] ?? {}),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'analysisDate': analysisDate,
    'dataPoints': dataPoints?.toJson(),
  };

  @override
  List<Object?> get props => [analysisDate, dataPoints];
}
