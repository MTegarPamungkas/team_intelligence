import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/activity/domain/entities/activity_entity.dart';
import 'package:team_intelligence/shared/features/activity/domain/repositories/activity_repository.dart';

class Activity {
  final ActivityRepository repository;

  Activity(this.repository);

  Future<Either<Failure, ActivityEntity>> call(String id) async {
    return await repository.getActivity(id);
  }
}
