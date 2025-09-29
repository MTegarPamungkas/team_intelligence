class NavigationState {
  final int currentIndex;

  const NavigationState({this.currentIndex = 0});

  NavigationState copyWith({int? currentIndex}) {
    return NavigationState(currentIndex: currentIndex ?? this.currentIndex);
  }
}

class VoiceAssistantState {
  final bool isListening;
  final bool isProcessing;

  const VoiceAssistantState({
    this.isListening = false,
    this.isProcessing = false,
  });

  VoiceAssistantState copyWith({bool? isListening, bool? isProcessing}) {
    return VoiceAssistantState(
      isListening: isListening ?? this.isListening,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
