import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/insight/domain/entities/insight_entity.dart';
import 'package:team_intelligence/shared/features/insight/domain/repositories/insight_repository.dart';

class Insight {
  final InsightRepository repository;

  Insight(this.repository);

  Future<Either<Failure, InsightEntity>> call(String id) async {
    return await repository.getInsight(id);
  }
}
