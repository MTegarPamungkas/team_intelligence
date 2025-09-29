import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/activity/domain/entities/activity_entity.dart';

abstract class ActivityRepository {
  Future<Either<Failure, ActivityEntity>> getActivity(String id);
}
