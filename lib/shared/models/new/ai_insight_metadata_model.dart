import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class AiInsightMetadataModel extends Equatable implements BaseModel {
  final int? count;

  const AiInsightMetadataModel({this.count});

  factory AiInsightMetadataModel.fromJson(Map<String, dynamic> json) {
    return AiInsightMetadataModel(count: json['count'] as int? ?? 0);
  }

  @override
  Map<String, dynamic> toJson() => {'count': count};

  @override
  List<Object?> get props => [count];
}
