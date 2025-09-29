import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class ProgressUpdateMetadataModel extends Equatable implements BaseModel {
  final double? oldProgress;
  final double? newProgress;
  final double? progressDelta;

  const ProgressUpdateMetadataModel({
    this.oldProgress,
    this.newProgress,
    this.progressDelta,
  });

  factory ProgressUpdateMetadataModel.fromJson(Map<String, dynamic> json) {
    return ProgressUpdateMetadataModel(
      oldProgress: (json['oldProgress'] as num?)?.toDouble() ?? 0.0,
      newProgress: (json['newProgress'] as num?)?.toDouble() ?? 0.0,
      progressDelta: (json['progressDelta'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'oldProgress': oldProgress,
    'newProgress': newProgress,
    'progressDelta': progressDelta,
  };

  @override
  List<Object?> get props => [oldProgress, newProgress, progressDelta];
}
