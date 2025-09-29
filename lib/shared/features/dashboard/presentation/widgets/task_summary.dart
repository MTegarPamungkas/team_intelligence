// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'package:team_intelligence/shared/widgets/cards/base_card.dart';
import 'task_stat_card.dart';

class TaskSummary extends StatelessWidget {
  final SummaryEntity data;

  const TaskSummary({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final taskSummary = data.taskSummary;
    final totalTasks = taskSummary?.totalTasks ?? 0;
    final completedTasks = taskSummary?.completedTasks ?? 0;
    final pendingTasks = totalTasks - completedTasks;

    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.task_alt, color: context.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Task Summary',
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
                child: TaskStatCard(
                  label: 'Total Tasks',
                  value: '$totalTasks',
                  icon: Icons.list_alt,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TaskStatCard(
                  label: 'Completed',
                  value: '$completedTasks',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TaskStatCard(
                  label: 'Pending',
                  value: '$pendingTasks',
                  icon: Icons.pending,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Completion Rate',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    '${taskSummary?.completionRate ?? 0}%',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (taskSummary?.completionRate ?? 0) / 100,
                  minHeight: 8,
                  backgroundColor: Colors.green.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
