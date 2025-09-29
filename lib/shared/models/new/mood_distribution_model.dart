import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class MoodDistributionModel extends Equatable implements BaseModel {
  final int? productive;
  final int? creative;
  final int? focused;
  final int? happy;
  final int? mad;
  final int? waiting;

  const MoodDistributionModel({
    this.productive,
    this.creative,
    this.focused,
    this.happy,
    this.mad,
    this.waiting,
  });

  factory MoodDistributionModel.fromJson(Map<String, dynamic> json) {
    return MoodDistributionModel(
      productive: json['productive'] as int? ?? 0,
      creative: json['creative'] as int? ?? 0,
      focused: json['focused'] as int? ?? 0,
      happy: json['happy'] as int? ?? 0,
      mad: json['mad'] as int? ?? 0,
      waiting: json['waiting'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'productive': productive,
    'creative': creative,
    'focused': focused,
    'happy': happy,
    'mad': mad,
    'waiting': waiting,
  };

  @override
  List<Object?> get props => [
    productive,
    creative,
    focused,
    happy,
    mad,
    waiting,
  ];
}
