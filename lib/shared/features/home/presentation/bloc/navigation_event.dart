abstract class NavigationEvent {}

abstract class VoiceAssistantEvent {}

class NavigationTabChanged extends NavigationEvent {
  final int index;
  NavigationTabChanged(this.index);
}

class VoiceAssistantToggle extends VoiceAssistantEvent {}

class VoiceAssistantStart extends VoiceAssistantEvent {}

class VoiceAssistantStop extends VoiceAssistantEvent {}
