import 'package:flutter/material.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'project_card.dart';
import 'metrics_grid.dart';
import 'performance_section.dart';
import 'team_members_section.dart';
import 'task_summary.dart';

class DashboardContent extends StatelessWidget {
  final SummaryEntity data;

  const DashboardContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project Header Card
        ProjectCard(data: data),
        const SizedBox(height: 16),

        // Metrics Overview Grid
        MetricsGrid(data: data),
        const SizedBox(height: 16),

        // Team Performance Section
        PerformanceSection(data: data),
        const SizedBox(height: 16),

        // Team Members List
        TeamMembersSection(data: data),
        const SizedBox(height: 16),

        // Task Summary
        TaskSummary(data: data),
      ],
    );
  }
}
