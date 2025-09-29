import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/user_model.dart';

class AuthEntity extends Equatable {
  final String? message;
  final String? token;
  final UserModel? user;

  const AuthEntity({this.message, this.token, this.user});

  @override
  List<Object?> get props => [user?.id, user?.name];
}
