import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class CommitMetadataModel extends Equatable implements BaseModel {
  final String? commitHash;
  final int? filesChanged;
  final int? linesAdded;
  final int? linesDeleted;

  const CommitMetadataModel({
    this.commitHash,
    this.filesChanged,
    this.linesAdded,
    this.linesDeleted,
  });

  factory CommitMetadataModel.fromJson(Map<String, dynamic> json) {
    return CommitMetadataModel(
      commitHash: json['commitHash'] as String? ?? '',
      filesChanged: json['filesChanged'] as int? ?? 0,
      linesAdded: json['linesAdded'] as int? ?? 0,
      linesDeleted: json['linesDeleted'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'commitHash': commitHash,
    'filesChanged': filesChanged,
    'linesAdded': linesAdded,
    'linesDeleted': linesDeleted,
  };

  @override
  List<Object?> get props => [
    commitHash,
    filesChanged,
    linesAdded,
    linesDeleted,
  ];
}
