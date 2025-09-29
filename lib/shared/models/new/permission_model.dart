import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class PermissionsModel extends Equatable implements BaseModel {
  final bool? read;
  final bool? write;
  final bool? comment;
  final bool? delete;
  final bool? manage_members;
  final bool? assign_tasks;
  final bool? generate_insights;

  const PermissionsModel({
    this.read,
    this.write,
    this.comment,
    this.delete,
    this.manage_members,
    this.assign_tasks,
    this.generate_insights,
  });

  factory PermissionsModel.fromJson(Map<String, dynamic> json) {
    return PermissionsModel(
      read: json['read'] as bool? ?? false,
      write: json['write'] as bool? ?? false,
      comment: json['comment'] as bool? ?? false,
      delete: json['delete'] as bool? ?? false,
      manage_members: json['manage_members'] as bool? ?? false,
      assign_tasks: json['assign_tasks'] as bool? ?? false,
      generate_insights: json['generate_insights'] as bool? ?? false,
    );
  }

  factory PermissionsModel.fromJsonApi(Map<String, dynamic> json) {
    return PermissionsModel(
      read: json['read'],
      write: json['write'],
      comment: json['comment'],
      delete: json['delete'],
      manage_members: json['manage_members'],
      assign_tasks: json['assign_tasks'],
      generate_insights: json['generate_insights'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'read': read,
    'write': write,
    'comment': comment,
    'delete': delete,
    'manage_members': manage_members,
    'assign_tasks': assign_tasks,
    'generate_insights': generate_insights,
  };

  @override
  List<Object?> get props => [
    read,
    write,
    comment,
    delete,
    manage_members,
    assign_tasks,
    generate_insights,
  ];

  PermissionsModel toEntity() => PermissionsModel(
    read: read,
    write: write,
    comment: comment,
    delete: delete,
    manage_members: manage_members,
    assign_tasks: assign_tasks,
    generate_insights: generate_insights,
  );
}
