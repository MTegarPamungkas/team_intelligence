import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/insight/presentation/bloc/insight_bloc.dart';
import 'package:team_intelligence/shared/features/insight/presentation/bloc/insight_event.dart';
import 'package:team_intelligence/shared/features/insight/presentation/bloc/insight_state.dart';
import 'package:team_intelligence/shared/features/insight/domain/usecases/insight.dart';
import 'package:team_intelligence/shared/features/insight/presentation/widgets/insights_list_widget.dart';
import 'package:team_intelligence/shared/features/insight/presentation/widgets/priority_overview_widget.dart';
import 'package:team_intelligence/shared/widgets/indicators/loading_indicator.dart';
import 'package:team_intelligence/shared/widgets/layouts/scaffold_wrapper.dart';
import 'package:team_intelligence/shared/widgets/cards/empty_state_widgets.dart';

class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: Container(
        // ignore: deprecated_member_use
        color: context.colorScheme.onSurface.withOpacity(0.03),
        child: BlocProvider(
          create: (context) =>
              InsightBloc(GetIt.instance<Insight>())..add(FetchInsight()),
          child: BlocBuilder<InsightBloc, InsightState>(
            builder: (context, state) {
              if (state is InsightLoading) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: LoadingIndicator.overlay(
                    color: context.colorScheme.onSurface,
                    size: 30,
                  ),
                );
              } else if (state is InsightError) {
                return EmptyStateWidgets.buildNoProjectMessage(context);
              } else if (state is InsightLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<InsightBloc>().add(FetchInsight());
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PriorityOverviewWidget(state: state),
                          const SizedBox(height: 24),
                          InsightsListWidget(state: state),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
