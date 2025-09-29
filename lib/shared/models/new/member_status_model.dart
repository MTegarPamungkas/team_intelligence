import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class MemberStatusModel extends Equatable implements BaseModel {
  final int? active;
  final int? available;
  final int? blocked;

  const MemberStatusModel({this.active, this.available, this.blocked});

  factory MemberStatusModel.fromJson(Map<String, dynamic> json) {
    return MemberStatusModel(
      active: json['active'] as int? ?? 0,
      available: json['available'] as int? ?? 0,
      blocked: json['blocked'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'active': active,
    'available': available,
    'blocked': blocked,
  };

  @override
  List<Object?> get props => [active, available, blocked];
}
