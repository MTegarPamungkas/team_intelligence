// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'package:team_intelligence/shared/widgets/cards/base_card.dart';
import 'member_item.dart';

class TeamMembersSection extends StatelessWidget {
  final SummaryEntity data;

  const TeamMembersSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final members = data.teamMembers ?? [];
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups, color: context.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Team Members',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '${members.length} members',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...members.map((member) => MemberItem(member: member)).toList(),
        ],
      ),
    );
  }
}
