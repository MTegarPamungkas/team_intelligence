import 'package:flutter/material.dart';
import 'package:team_intelligence/shared/enums/activity_type.dart';
import 'package:team_intelligence/shared/enums/insight_priority.dart';

class ColorHelper {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'focused':
        return const Color(0xFF10B981);
      case 'available':
        return const Color(0xFF3B82F6);
      case 'blocked':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  static Color getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return const Color(0xFFF59E0B);
      case 'mad':
        return const Color(0xFFEF4444);
      case 'focused':
        return const Color(0xFF10B981);
      case 'creative':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  static Color getActivityColor(ActivityType type) {
    switch (type.name.toLowerCase()) {
      case 'meeting':
        return const Color(0xFF10B981); // Emerald
      case 'codereview':
        return const Color(0xFF8B5CF6); // Violet
      case 'taskcomplete':
        return const Color(0xFF06B6D4); // Cyan
      case 'commit':
        return const Color(0xFFEF4444); // Red
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }

  static Color getPriorityColor(InsightPriority priority) {
    switch (priority.name) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.blue;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
