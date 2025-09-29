// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';

class SkeletonListTile {
  static Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.onSurface.withOpacity(0.1),
      highlightColor: context.colorScheme.onSurface.withOpacity(0.2),
      child: ListTile(
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        title: Container(
          width: double.infinity,
          height: 16,
          color: Colors.grey[300],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
