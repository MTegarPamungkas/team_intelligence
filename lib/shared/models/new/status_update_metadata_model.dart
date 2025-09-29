import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class StatusUpdateMetadataModel extends Equatable implements BaseModel {
  final String? oldStatus;
  final String? newStatus;
  final String? reason;

  const StatusUpdateMetadataModel({
    this.oldStatus,
    this.newStatus,
    this.reason,
  });

  factory StatusUpdateMetadataModel.fromJson(Map<String, dynamic> json) {
    return StatusUpdateMetadataModel(
      oldStatus: json['oldStatus'] as String? ?? '',
      newStatus: json['newStatus'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'oldStatus': oldStatus,
    'newStatus': newStatus,
    'reason': reason,
  };

  @override
  List<Object?> get props => [oldStatus, newStatus, reason];
}
