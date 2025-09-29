// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/core/utils/helpers/Icon_helper.dart';
import 'package:team_intelligence/core/utils/helpers/bool_helper.dart';
import 'package:team_intelligence/core/utils/helpers/color_helper.dart';
import 'package:team_intelligence/core/utils/helpers/formatter.dart';
import 'package:team_intelligence/shared/models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final int index;
  final VoidCallback? onTap;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activityType = activity.type;
    final iconData = IconHelper.getActivityIcon(activityType);
    final iconColor = ColorHelper.getActivityColor(activityType);
    final timeAgo = Formatter.formatTimeAgo(activity.timestamp.toString());
    final isRecent = BoolHelper.isRecentActivity(activity.timestamp.toString());

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'activity_icon_$index',
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [iconColor.withOpacity(0.8), iconColor],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(iconData, color: Colors.white, size: 24),
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  activity.userName,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.colorScheme.onSurface
                                            .withOpacity(0.9),
                                      ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      iconColor.withOpacity(0.1),
                                      iconColor.withOpacity(0.05),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: iconColor.withOpacity(0.2),
                                  ),
                                ),
                                child: Text(
                                  Formatter.formatActivityType(activityType),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: iconColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          if (isRecent) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '🔥 Recent',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xFF10B981),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onSurface.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorScheme.onSurface.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    activity.action,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.7),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onSurface.withOpacity(0.025),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: context.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: context.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
