import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, SummaryEntity>> getDashboard(String id);
}
