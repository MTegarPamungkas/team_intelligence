import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/context_used_model.dart';

class MessageModel extends Equatable implements BaseModel {
  final String? id;
  final String? role;
  final String? content;
  final String? timestamp;
  final ContextUsedModel? contextUsed;

  const MessageModel({
    this.id,
    this.role,
    this.content,
    this.timestamp,
    this.contextUsed,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      content: json['content'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      contextUsed: json['contextUsed'] != null
          ? ContextUsedModel.fromJson(json['contextUsed'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role,
    'content': content,
    'timestamp': timestamp,
    if (contextUsed != null) 'contextUsed': contextUsed!.toJson(),
  };

  @override
  List<Object?> get props => [id, role, content, timestamp, contextUsed];
}
