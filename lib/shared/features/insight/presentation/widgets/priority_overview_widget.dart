// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/insight/presentation/bloc/insight_state.dart';
import 'package:team_intelligence/shared/features/insight/presentation/widgets/priority_chip_widget.dart';

class PriorityOverviewWidget extends StatelessWidget {
  final InsightLoaded state;

  const PriorityOverviewWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final priorities = state.entity.insightsByPriority;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Priority Overview',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PriorityChipWidget(
                    label: 'Critical',
                    count: priorities!.critical,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PriorityChipWidget(
                    label: 'High',
                    count: priorities.high,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PriorityChipWidget(
                    label: 'Medium',
                    count: priorities.medium,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PriorityChipWidget(
                    label: 'Low',
                    count: priorities.low,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
