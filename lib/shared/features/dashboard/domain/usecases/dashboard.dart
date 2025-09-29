import 'package:dartz/dartz.dart';
import 'package:team_intelligence/core/error/failures.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/repositories/dashboard_repository.dart';

class Dashboard {
  final DashboardRepository repository;

  Dashboard(this.repository);

  Future<Either<Failure, SummaryEntity>> getProjectSummary(String id) async {
    return await repository.getDashboard(id);
  }
}
