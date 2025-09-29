import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/auth/domain/entities/auth_entity.dart';
import 'package:team_intelligence/shared/features/auth/domain/repositories/auth_repository.dart';

class Auth {
  final AuthRepository repository;

  Auth(this.repository);

  Future<Either<Failure, AuthEntity>> login(
    String email,
    String password,
  ) async {
    return await repository.login(email, password);
  }

  Future<Either<Failure, AuthEntity>> register(
    String name,
    String email,
    String password,
  ) async {
    return await repository.register(name, email, password);
  }
}
