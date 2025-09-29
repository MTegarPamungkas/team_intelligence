import 'package:equatable/equatable.dart';
import 'package:team_intelligence/shared/models/base_model.dart';

class UserModel extends Equatable implements BaseModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? role;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      role: json['role'] as String? ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password, // Catatan: Pertimbangkan untuk tidak menyertakan ini
    'role': role,
    'createdAt': createdAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, name, email, password, role, createdAt];
}
