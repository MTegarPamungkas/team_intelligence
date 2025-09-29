import 'package:flutter/material.dart';
import 'package:team_intelligence/shared/enums/activity_type.dart';
import 'package:team_intelligence/shared/enums/insight_type.dart';

class IconHelper {
  static IconData getActivityIcon(ActivityType type) {
    switch (type.name.toLowerCase()) {
      case 'meeting':
        return Icons.people_rounded;
      case 'codereview':
        return Icons.code_rounded;
      case 'taskcomplete':
        return Icons.check_circle_rounded;
      case 'commit':
        return Icons.commit_rounded;
      default:
        return Icons.timeline_rounded;
    }
  }

  static IconData getInsightIcon(InsightType type) {
    switch (type) {
      case InsightType.bottleneckDetection:
        return Icons.warning_amber_rounded;
      case InsightType.timingOptimization:
        return Icons.schedule;
      case InsightType.workloadRedistribution:
        return Icons.people_alt_outlined;
      default:
        return Icons.lightbulb_outline;
    }
  }
}
