import 'package:flutter/material.dart';
import 'package:team_intelligence/core/utils/helpers/color_helper.dart';

class MoodBadge extends StatelessWidget {
  final String mood;

  const MoodBadge({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    Color color = ColorHelper.getMoodColor(mood);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        mood.toLowerCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
