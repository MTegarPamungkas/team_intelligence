import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/features/auth/domain/entities/auth_entity.dart';
import 'package:team_intelligence/shared/models/base_model.dart';
import 'package:team_intelligence/shared/models/user_model.dart';

class AuthModel extends Equatable implements BaseModel {
  final String? message;
  final String? token;
  final UserModel? user;

  const AuthModel({this.message, this.token, this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      message: json['message'],
      token: json['token'],
      user: UserModel.fromJson(json['user']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'message': message,
    'token': token,
    'user': user?.toJson(),
  };

  AuthEntity toEntity() =>
      AuthEntity(message: message, token: token, user: user);

  @override
  List<Object?> get props => [user?.id, user?.name];
}
