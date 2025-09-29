import 'package:flutter/material.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/insight/presentation/bloc/insight_state.dart';
import 'package:team_intelligence/shared/features/insight/presentation/widgets/insights_card_widget.dart';

class InsightsListWidget extends StatelessWidget {
  final InsightLoaded state;

  const InsightsListWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Insights',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.entity.insights!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final insight = state.entity.insights?[index];
            return InsightCardWidget(insight: insight!);
          },
        ),
      ],
    );
  }
}
