import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/new/message_model.dart';

class ChatModel extends Equatable implements BaseModel {
  final String? id;
  final String? projectId;
  final String? userId;
  final String? title;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final List<MessageModel>? messages;

  const ChatModel({
    this.id,
    this.projectId,
    this.userId,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String? ?? '',
      projectId: json['projectId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((item) => MessageModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'userId': userId,
    'title': title,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'messages': messages?.map((message) => message.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    id,
    projectId,
    userId,
    title,
    status,
    createdAt,
    updatedAt,
    messages,
  ];
}
