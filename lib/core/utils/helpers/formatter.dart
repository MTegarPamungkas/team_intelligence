import 'package:team_intelligence/shared/enums/activity_type.dart';
import 'package:team_intelligence/shared/enums/insight_type.dart';

class Formatter {
  static String formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Unknown date';
    }
    try {
      DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  static String formatTimeAgo(String? timestamp) {
    if (timestamp == null) return 'Unknown time';

    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown time';
    }
  }

  static String formatActivityType(ActivityType type) {
    switch (type.name.toLowerCase()) {
      case 'meeting':
        return 'MEETING';
      case 'codereview':
        return 'CODE REVIEW';
      case 'taskcomplete':
        return 'COMPLETED';
      case 'commit':
        return 'COMMIT';
      default:
        return 'ACTIVITY';
    }
  }

  static String formatInsightTypeLabel(InsightType type) {
    switch (type) {
      case InsightType.bottleneckDetection:
        return 'Bottleneck Detection';
      case InsightType.timingOptimization:
        return 'Timing Optimization';
      case InsightType.workloadRedistribution:
        return 'Workload Redistribution';
      default:
        return 'Insight';
    }
  }
}
