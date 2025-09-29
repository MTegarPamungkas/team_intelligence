import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/insight/domain/entities/insight_entity.dart';

abstract class InsightRepository {
  Future<Either<Failure, InsightEntity>> getInsight(String id);
}
