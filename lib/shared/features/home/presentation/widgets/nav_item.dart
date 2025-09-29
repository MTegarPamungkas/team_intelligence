import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_intelligence/app/theme/color_scheme.dart';
import 'package:team_intelligence/app/theme/text_theme.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_bloc.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_event.dart';

class NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final bool isSelected;

  const NavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<NavigationBloc>().add(NavigationTabChanged(index));
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? AppColorScheme.lightPrimary
                    : context.colorScheme.onSurface,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style:
                    AppTextTheme.withColor(
                      context.textTheme.labelSmall!,
                      isSelected
                          ? AppColorScheme.lightPrimary
                          : context.colorScheme.onSurface,
                    ).copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
