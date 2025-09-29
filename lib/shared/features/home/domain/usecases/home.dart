import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/home_entity.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/my_projects_entity.dart';
import 'package:team_intelligence/shared/features/home/domain/repositories/home_repository.dart';

class Home {
  final HomeRepository repository;

  Home(this.repository);

  Future<Either<Failure, HomeEntity>> call() async {
    return await repository.getHome();
  }

  Future<Either<Failure, MyProjectsEntity>> getMyProjects() async {
    return await repository.getMyProjects();
  }
}
