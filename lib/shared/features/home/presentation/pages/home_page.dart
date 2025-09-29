import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/shared/features/activity/presentation/pages/activity_page.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:team_intelligence/shared/features/home/domain/usecases/home.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/home_bloc.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_bloc.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_state.dart';
import 'package:team_intelligence/shared/features/home/presentation/widgets/app_bar.dart';
import 'package:team_intelligence/shared/features/home/presentation/widgets/bottom_navbar.dart';
import 'package:team_intelligence/shared/features/home/presentation/widgets/voice_assistant_fab.dart';
import 'package:team_intelligence/shared/features/insight/presentation/pages/insight_page.dart';
import 'package:team_intelligence/shared/widgets/layouts/scaffold_wrapper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildCurrentPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return DashboardPage();
      case 1:
        return ActivityPage();
      case 2:
        return InsightPage();
      case 3:
        return const Center(child: Text('Chat Page'));
      default:
        return const Center(child: Text('Dashboard Page'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => GetIt.instance<HomeBloc>()),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(GetIt.instance<Home>()),
        ),

        BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        BlocProvider<VoiceAssistantBloc>(
          create: (context) => VoiceAssistantBloc(),
        ),
      ],

      child: ScaffoldWrapper(
        extendBodyBehindAppBar: false,
        appBar: SyncAppBar(),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, navState) {
            return _buildCurrentPage(navState.currentIndex);
          },
        ),
        bottomNavigationBar: const BottomNavbar(),
        floatingActionButton: const VoiceAssistantFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
