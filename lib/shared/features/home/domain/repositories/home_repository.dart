import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/home_entity.dart';
import 'package:team_intelligence/shared/features/home/domain/entities/my_projects_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeEntity>> getHome();
  Future<Either<Failure, MyProjectsEntity>> getMyProjects();
}
