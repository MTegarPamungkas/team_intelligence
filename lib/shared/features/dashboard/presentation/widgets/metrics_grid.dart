import 'package:flutter/material.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'metric_card.dart';

class MetricsGrid extends StatelessWidget {
  final SummaryEntity data;

  const MetricsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final metrics = data.teamMetrics;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: [
        MetricCard(
          icon: Icons.people,
          title: 'Team Members',
          value: '${metrics?.totalMembers ?? 0}',
          subtitle: '${metrics?.memberStatus?.active ?? 0} active',
          color: Colors.blue,
        ),
        MetricCard(
          icon: Icons.speed,
          title: 'Avg Efficiency',
          value:
              '${((metrics?.performance?.avgEfficiency ?? 0) * 100).toInt()}%',
          subtitle: 'Performance rate',
          color: Colors.green,
        ),
        MetricCard(
          icon: Icons.timer,
          title: 'Focus Time',
          value: '${metrics?.performance?.totalFocusTime ?? 0}h',
          subtitle: 'Total hours',
          color: Colors.orange,
        ),
        MetricCard(
          icon: Icons.emoji_emotions,
          title: 'Team Mood',
          value:
              '${(metrics?.moodDistribution?.productive ?? 0) + (metrics?.moodDistribution?.creative ?? 0)}',
          subtitle: 'Positive moods',
          color: Colors.purple,
        ),
      ],
    );
  }
}
