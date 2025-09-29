import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_bloc.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_state.dart';
import 'package:team_intelligence/shared/features/home/presentation/widgets/nav_item.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            color: context.colorScheme.surface,
            elevation: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItem(
                  index: 0,
                  icon: Icons.dashboard_rounded,
                  label: 'Dashboard',
                  isSelected: state.currentIndex == 0,
                ),
                NavItem(
                  index: 1,
                  icon: Icons.timeline_rounded,
                  label: 'Activity',
                  isSelected: state.currentIndex == 1,
                ),
                const SizedBox(width: 80),
                NavItem(
                  index: 2,
                  icon: Icons.psychology_rounded,
                  label: 'Insights',
                  isSelected: state.currentIndex == 2,
                ),
                NavItem(
                  index: 3,
                  icon: Icons.forum,
                  label: 'Chat',
                  isSelected: state.currentIndex == 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
