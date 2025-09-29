import 'package:flutter/material.dart';

class ActivityHeader extends StatelessWidget {
  const ActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Activity',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}