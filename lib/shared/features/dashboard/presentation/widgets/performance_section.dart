// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'package:team_intelligence/shared/widgets/cards/base_card.dart';
import 'performance_item.dart';

class PerformanceSection extends StatelessWidget {
  final SummaryEntity data;

  const PerformanceSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final performance = data.teamMetrics?.performance;
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart, color: context.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Team Performance',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: PerformanceItem(
                  label: 'Efficiency',
                  value:
                      '${((performance?.avgEfficiency ?? 0) * 100).toInt()}%',
                  progress: performance?.avgEfficiency ?? 0,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PerformanceItem(
                  label: 'Completion',
                  value: '${performance?.completionRate ?? 0}%',
                  progress: (performance?.completionRate ?? 0) / 100,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
