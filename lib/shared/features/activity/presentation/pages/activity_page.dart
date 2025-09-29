// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/enums/activity_type.dart';
import 'package:team_intelligence/shared/features/activity/presentation/bloc/activity_bloc.dart';
import 'package:team_intelligence/shared/features/activity/presentation/widgets/activity_card.dart';
import 'package:team_intelligence/shared/features/activity/presentation/widgets/activity_empty_widget.dart';
import 'package:team_intelligence/shared/features/activity/presentation/widgets/activity_stats_card.dart';
import 'package:team_intelligence/shared/features/activity/presentation/widgets/quick_stat_card.dart';
import 'package:team_intelligence/shared/models/activity_model.dart';
import 'package:team_intelligence/shared/widgets/cards/empty_state_widgets.dart';
import 'package:team_intelligence/shared/widgets/indicators/loading_indicator.dart';
import 'package:team_intelligence/shared/widgets/layouts/scaffold_wrapper.dart';
import 'package:team_intelligence/shared/features/activity/presentation/bloc/activity_event.dart';
import 'package:team_intelligence/shared/features/activity/presentation/bloc/activity_state.dart';
import 'package:team_intelligence/shared/features/activity/domain/usecases/activity.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: Container(
        color: context.colorScheme.onSurface.withOpacity(0.03),
        child: BlocProvider(
          create: (context) =>
              ActivityBloc(GetIt.instance<Activity>())..add(FetchActivity()),
          child: BlocListener<ActivityBloc, ActivityState>(
            listener: (context, state) {
              if (state is ActivityLoaded) {}
            },
            child: BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
                if (state is ActivityLoading) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: LoadingIndicator.overlay(
                      color: context.colorScheme.onSurface,
                      size: 30,
                    ),
                  );
                } else if (state is ActivityError) {
                  return EmptyStateWidgets.buildNoProjectMessage(context);
                } else if (state is ActivityLoaded) {
                  return _buildActivityList(context, state);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityList(BuildContext context, ActivityLoaded state) {
    if (state.entity.activities!.isEmpty) {
      return const ActivityEmptyWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ActivityBloc>().add(FetchActivity());
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ActivityStatsCard(
                    totalActivities: state.entity.totalActivities ?? 0,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: QuickStatCard(
                          title: 'Meetings',
                          count: _countByType(
                            state.entity.activities!,
                            ActivityType.meeting,
                          ),
                          color: const Color(0xFF10B981),
                          icon: Icons.people_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: QuickStatCard(
                          title: 'Reviews',
                          count: _countByType(
                            state.entity.activities!,
                            ActivityType.codeReview,
                          ),
                          color: const Color(0xFF8B5CF6),
                          icon: Icons.code_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final activity = state.entity.activities![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ActivityCard(
                    activity: activity,
                    index: index,
                    onTap: () {},
                  ),
                );
              }, childCount: state.entity.activities!.length),
            ),
          ),
        ],
      ),
    );
  }

  int _countByType(List<ActivityModel> activities, ActivityType type) {
    return activities.where((activity) => activity.type == type).length;
  }
}
