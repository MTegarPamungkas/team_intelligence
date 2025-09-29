import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class UserModel extends Equatable implements BaseModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? defaultRole;
  final String? avatar;
  final String? createdAt;
  final String? lastLogin;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.defaultRole,
    this.avatar,
    this.createdAt,
    this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      defaultRole: json['defaultRole'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      lastLogin: json['lastLogin'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password, // Catatan: Pertimbangkan untuk tidak menyertakan ini
    'defaultRole': defaultRole,
    'avatar': avatar,
    'createdAt': createdAt,
    'lastLogin': lastLogin,
  };

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    password,
    defaultRole,
    avatar,
    createdAt,
    lastLogin,
  ];
}
