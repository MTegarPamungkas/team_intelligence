import 'package:flutter/material.dart';

class InsightHeader extends StatelessWidget {
  const InsightHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Insight',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}