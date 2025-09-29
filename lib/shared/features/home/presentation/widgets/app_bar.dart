import 'package:flutter/material.dart';
import 'package:team_intelligence/app/theme/color_scheme.dart';
import 'package:team_intelligence/app/theme/text_theme.dart';
import 'package:team_intelligence/core/utils/extensions/context_extension.dart';
import 'package:team_intelligence/core/utils/material/bottom_sheet_helper.dart';
import 'package:team_intelligence/l10n/l10n_extensions.dart';
import 'package:team_intelligence/shared/constants/asset_paths.dart';

class SyncAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SyncAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColorScheme.lightPrimary,
                  AppColorScheme.lightSecondary,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(AssetPaths.logo),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SYNC',
                style: AppTextTheme.withColor(
                  AppTextTheme.appBarTitle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                  context.colorScheme.onSurface,
                ),
              ),
              Text(
                context.l10n.appTagline,
                style: AppTextTheme.withColor(
                  context.textTheme.bodySmall!,
                  context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifikasi diklik')),
                );
              },
              icon: const Icon(Icons.notifications_outlined),
              color: context.colorScheme.onSurface,
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColorScheme.lightError,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => {BottomSheetHelper.showSettingsBottomSheet(context)},
          icon: const Icon(Icons.settings_outlined),
          color: context.colorScheme.onSurface,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
