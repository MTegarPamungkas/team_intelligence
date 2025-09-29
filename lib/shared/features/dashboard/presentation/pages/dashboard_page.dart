// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/entities/summary_entity.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/usecases/dashboard.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:team_intelligence/shared/widgets/cards/empty_state_widgets.dart';
import 'package:team_intelligence/shared/widgets/indicators/loading_indicator.dart';
import 'package:team_intelligence/shared/widgets/layouts/scaffold_wrapper.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) =>
          DashboardBloc(GetIt.instance<Dashboard>())..add(FetchDashboard()),
      child: ScaffoldWrapper(
        body: Container(
          color: context.colorScheme.onSurface.withOpacity(0.03),
          child: Builder(
            builder: (BuildContext refreshContext) {
              return RefreshIndicator(
                onRefresh: () async {
                  refreshContext.read<DashboardBloc>().add(FetchDashboard());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocListener<DashboardBloc, DashboardState>(
                        listener: (context, state) {
                          if (state is DashboardLoaded) {
                            // Handle success if needed
                          } else if (state is DashboardError) {
                            // Handle error if needed
                          }
                        },
                        child: BlocBuilder<DashboardBloc, DashboardState>(
                          builder: (context, state) {
                            if (state is DashboardLoading) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: LoadingIndicator.overlay(
                                  color: context.colorScheme.onSurface,
                                  size: 30,
                                ),
                              );
                            } else if (state is DashboardError) {
                              return EmptyStateWidgets.buildNoProjectMessage(
                                context,
                              );
                            } else if (state is DashboardLoaded) {
                              return _buildDashboardContent(
                                context,
                                state.entity,
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    SummaryEntity dashboardData,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardContent(data: dashboardData),
        // if (dashboardData.teamMetrics != null)
        //   DashboardMetrics(metrics: dashboardData.teamMetrics!),
        // const SizedBox(height: 24),
        // if (dashboardData.teamMember != null &&
        //     dashboardData.teamMember!.isNotEmpty)
        //   DashboardTeamMembers(teamMembers: dashboardData.teamMember!),
      ],
    );
  }
}
