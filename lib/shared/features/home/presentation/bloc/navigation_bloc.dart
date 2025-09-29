import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_event.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigationTabChanged>((event, emit) {
      emit(state.copyWith(currentIndex: event.index));
    });
  }
}

class VoiceAssistantBloc
    extends Bloc<VoiceAssistantEvent, VoiceAssistantState> {
  VoiceAssistantBloc() : super(const VoiceAssistantState()) {
    on<VoiceAssistantToggle>((event, emit) {
      HapticFeedback.mediumImpact();

      if (state.isListening) {
        print('🔇 Voice Assistant: OFF - Stopped listening');
        emit(state.copyWith(isListening: false, isProcessing: false));
      } else {
        print('🎤 Voice Assistant: ON - Started listening...');
        emit(state.copyWith(isListening: true, isProcessing: false));
      }
    });

    on<VoiceAssistantStart>((event, emit) {
      HapticFeedback.mediumImpact();
      print('🎤 Voice Assistant: STARTED - Begin listening session');
      emit(state.copyWith(isListening: true, isProcessing: false));
    });

    on<VoiceAssistantStop>((event, emit) {
      print('⏹️ Voice Assistant: STOPPED - End session');
      emit(state.copyWith(isListening: false, isProcessing: false));
    });
  }
}
