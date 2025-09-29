import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_intelligence/app/theme/color_scheme.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_bloc.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_event.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_state.dart';

class VoiceAssistantFab extends StatelessWidget {
  const VoiceAssistantFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceAssistantBloc, VoiceAssistantState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color:
                (state.isListening
                        ? AppColorScheme.lightError
                        : AppColorScheme.lightPrimary)
                    // ignore: deprecated_member_use
                    .withOpacity(0.9),

            borderRadius: BorderRadius.circular(35),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(35),
              onTap: () {
                context.read<VoiceAssistantBloc>().add(VoiceAssistantToggle());
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                child: Icon(
                  state.isListening ? Icons.mic : Icons.mic_none,
                  color: Colors.white,
                  size: 30,
                  key: ValueKey(state.isListening),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
